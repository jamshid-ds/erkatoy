import 'package:erkatoy_afex_ai/feature/auth/data/remote/source/auth_remote_source_impl.dart';
import 'package:erkatoy_afex_ai/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteSource remoteSource}) : _remoteSource = remoteSource;

  final AuthRemoteSource _remoteSource;

  @override
  Future<LoginResult> login({required String phone, required String password}) async {
    return await _remoteSource.loginUser(phone: phone, password: password).then((result) {
      if (result.detail == null) {
        return LoginResult(data: result.phone!);
      }
      return LoginResult(errorMessage: result.detail!);
    });
  }

  @override
  Future<RegisterResult> register({required String phone, required String password}) async {
    return await _remoteSource.registerUser(phone: phone, password: password).then((result) {
      if (result.detail == null) {
        return RegisterResult(data: result.phone!);
      }
      return RegisterResult(errorMessage: result.detail!);
    });
  }

  @override
  Future<ChildInfoResult> sendChildInfo({
    required String birthDayDate,
    required String gender,
    required double weight,
  }) async {
    return await _remoteSource
        .sendBabysInfo(birthDayDate: birthDayDate, gender: gender, weight: weight)
        .then((childInfo) {
      if (childInfo.userId != null) {
        return ChildInfoResult(data: '${childInfo.message} ${childInfo.userId}');
      }
      return ChildInfoResult(errorMessage: childInfo.message);
    });
  }
}
