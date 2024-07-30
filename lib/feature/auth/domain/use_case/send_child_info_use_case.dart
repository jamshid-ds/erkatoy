import 'package:erkatoy_afex_ai/feature/auth/domain/repository/auth_repository.dart';

class SendChildInfoUseCase {
  SendChildInfoUseCase({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  Future<ChildInfoResult> execute({
    required String birthDayDate,
    required String gender,
    required double weight,
  }) =>
      _repository.sendChildInfo(
        birthDayDate: birthDayDate,
        gender: gender,
        weight: weight,
      );
}
