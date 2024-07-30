import pickle

import joblib
import librosa
import numpy as np
import tensorflow as tf
import xgboost as xgb
from tensorflow.image import resize
from environs import Env
env = Env()
env.read_env()

tf.experimental.numpy.experimental_enable_numpy_behavior()


def preprocess_audio(file_path, target_shape=(128, 128)):
    audio_data, sample_rate = librosa.load(file_path, sr=None)
    mel_spectrogram = librosa.feature.melspectrogram(y=audio_data, sr=sample_rate)
    mel_spectrogram = resize(np.expand_dims(mel_spectrogram, axis=-1), target_shape)
    return mel_spectrogram


def cry_classification(audio_path):
    # DETECTION
    CLASS_NAMES = ['cry', 'not_cry']
    base_url = f"{env.str('BASE_PATH')}/cry_detector/"
    xgb_model = xgb.XGBClassifier()
    xgb_model.load_model(f"{base_url}cry_detector_model.json")
    scaler = joblib.load(f"{base_url}scaler.save")
    mel_spectrogram = preprocess_audio(audio_path)
    audio_data_reshaped = mel_spectrogram.reshape(1, -1)
    final_data = scaler.transform(audio_data_reshaped)
    # Make prediction
    xgb_pred = xgb_model.predict(final_data)
    xgb_pred_class = CLASS_NAMES[xgb_pred[0]]
    if xgb_pred_class == 'cry':
        classes = ['belly_pain', 'burping', 'discomfort', 'hungry', 'tired']
        with open(f"{base_url}class_model.pkl", 'rb') as file:
            model = pickle.load(file)
            file.close()
        preprocessed_audio = np.expand_dims(mel_spectrogram, axis=0)
        prediction = model.predict(preprocessed_audio)
        predicted_class = classes[np.argmax(prediction)]
        return predicted_class
    else:
        return "not_cry"
