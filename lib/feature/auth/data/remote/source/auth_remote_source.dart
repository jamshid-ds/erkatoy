part of 'auth_remote_source_impl.dart';

abstract interface class AuthRemoteSource {
  Future<AuthResponse> loginUser({required String phone, required String password});

  Future<AuthResponse> registerUser({required String phone, required String password});

  Future<ChildInfoDto> sendBabysInfo({
    required String birthDayDate,
    required String gender,
    required double weight,
  });
}
