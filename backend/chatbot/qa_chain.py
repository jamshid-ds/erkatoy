import os
from typing import List
from functools import lru_cache

import dotenv
from environs import Env
from langchain.chains.combine_documents import create_stuff_documents_chain
from langchain.prompts import ChatPromptTemplate
from langchain_community.chat_message_histories import SQLChatMessageHistory
from langchain_community.document_loaders import PyPDFLoader
from langchain_community.vectorstores import Chroma
from langchain_core.messages import BaseMessage
from langchain_core.prompts import MessagesPlaceholder
from langchain_core.runnables import RunnablePassthrough
from langchain_core.runnables.history import RunnableWithMessageHistory
from langchain_openai import ChatOpenAI, OpenAIEmbeddings
from langchain.retrievers import ContextualCompressionRetriever
from langchain.retrievers.document_compressors import LLMChainExtractor

from core.config import settings
from utils.async_utils import async_retry

env = Env()
env.read_env()
dotenv.load_dotenv()

persist_directory = "chroma_data/"
book_dir = "chatbot/book.pdf"

chat_model = ChatOpenAI(model=env.str('MODEL'), temperature=0.5)
embedding_model = OpenAIEmbeddings()

if not os.path.exists(persist_directory):
    loader = PyPDFLoader(book_dir)
    pages = loader.load_and_split()
    print('Database load started')
    vector_db = Chroma.from_documents(pages, embedding_model, persist_directory=persist_directory)
    print('Database copied to vector database')
else:
    vector_db = Chroma(persist_directory=persist_directory, embedding_function=embedding_model)

base_retriever = vector_db.as_retriever(search_kwargs={"k": 3})
compressor = LLMChainExtractor.from_llm(chat_model)
retriever = ContextualCompressionRetriever(base_compressor=compressor, base_retriever=base_retriever)

SYSTEM_TEMPLATE = """
You are a Childcare assistant. Answer the user's questions in Uzbek based on the below context. Be concise, as detailed as possible, 
but don't make up any information. If the question is out of topic just say don't know.

<context>
{context}
</context>
"""

question_answering_prompt = ChatPromptTemplate.from_messages(
    [
        ("system", SYSTEM_TEMPLATE),
        MessagesPlaceholder(variable_name="chat_history"),
        ("human", "{question}"),
    ]
)

document_chain = create_stuff_documents_chain(chat_model, question_answering_prompt)


def format_chat_history(chat_history: List[BaseMessage]) -> str:
    return "\n".join([f"{msg.type}: {msg.content}" for msg in chat_history])


@lru_cache(maxsize=100)
def cached_retrieval(question: str) -> str:
    docs = retriever.get_relevant_documents(question)
    return "\n\n".join(doc.page_content for doc in docs)


retrieval_chain = RunnablePassthrough.assign(
    context=lambda x: cached_retrieval(x["question"])
).assign(
    answer=document_chain
)

qa_chain = RunnableWithMessageHistory(
    retrieval_chain,
    lambda session_id: SQLChatMessageHistory(
        session_id=session_id, connection_string=settings.DATABASE_URL
    ),
    input_messages_key="question",
    history_messages_key="chat_history",
    output_messages_key="answer"
)


@async_retry(max_retries=3, delay=1)
async def invoke_agent_with_retry(query: str, user_id: str):
    """
    Retry the agent if a tool fails to run. This can help when there
    are intermittent connection issues to external APIs.
    """
    return qa_chain.invoke(
        {"question": query},
        config={"configurable": {"session_id": user_id}}
    )['answer']
