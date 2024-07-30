import 'package:erkatoy_afex_ai/feature/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  LoginUseCase({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  Future<LoginResult> execute({required String phone, required String password}) =>
      _repository.login(phone: phone, password: password);
}
