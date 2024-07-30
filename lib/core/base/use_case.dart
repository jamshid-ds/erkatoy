import 'dart:async';

abstract interface class BaseUseCase<OUTPUT> {
  Future<OUTPUT> execute();
}

abstract interface class BaseUseCaseWithParams<INPUT, OUTPUT> {
  Future<OUTPUT> execute(INPUT input);
}
