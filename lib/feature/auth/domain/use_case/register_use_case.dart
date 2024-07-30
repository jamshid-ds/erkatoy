import 'package:erkatoy_afex_ai/feature/auth/domain/repository/auth_repository.dart';

class RegisterUseCase {
  RegisterUseCase({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  Future<RegisterResult> execute({required String phone, required String password}) =>
      _repository.register(phone: phone, password: password);
}
