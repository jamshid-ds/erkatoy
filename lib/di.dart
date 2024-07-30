import 'package:erkatoy_afex_ai/core/provider/remote/api_client.dart';
import 'package:erkatoy_afex_ai/feature/auth/data/remote/source/auth_remote_source_impl.dart';
import 'package:erkatoy_afex_ai/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:erkatoy_afex_ai/feature/auth/domain/repository/auth_repository.dart';
import 'package:erkatoy_afex_ai/feature/auth/domain/use_case/login_use_case.dart';
import 'package:erkatoy_afex_ai/feature/auth/domain/use_case/register_use_case.dart';
import 'package:erkatoy_afex_ai/feature/auth/domain/use_case/send_child_info_use_case.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/creating_account/bloc/create_account_bloc.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/login/bloc/login_bloc.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/register/bloc/register_bloc.dart';
import 'package:erkatoy_afex_ai/feature/change_lang/bloc/change_lang_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/connectivity/connectivity_cubit.dart';
import 'core/provider/local/hive_local_storage.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt
    ..registerLazySingleton<ApiClient>(ApiClient.new)
    ..registerLazySingleton<HiveLocalStorage>(HiveLocalStorage.new)
    ..registerFactory<ConnectivityCubit>(ConnectivityCubit.new)
    ..registerFactory<ChangeLangBloc>(
      () => ChangeLangBloc(localStorage: getIt<HiveLocalStorage>()),
    )

    /// auth
    ..registerLazySingleton<AuthRemoteSource>(
        () => AuthRemoteSourceImpl(apiClient: getIt<ApiClient>()))
    ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remoteSource: getIt<AuthRemoteSource>()))
    ..registerFactory<SendChildInfoUseCase>(
        () => SendChildInfoUseCase(repository: getIt<AuthRepository>()))
    ..registerFactory<RegisterUseCase>(() => RegisterUseCase(repository: getIt<AuthRepository>()))
    ..registerFactory<LoginUseCase>(() => LoginUseCase(repository: getIt<AuthRepository>()))
    ..registerFactory<RegisterBloc>(() => RegisterBloc(registerUseCase: getIt<RegisterUseCase>()))
    ..registerFactory<CreateAccountBloc>(() => CreateAccountBloc(
          loginUseCase: getIt<LoginUseCase>(),
          sendChildInfoUseCase: getIt<SendChildInfoUseCase>(),
        ))
    ..registerFactory<LoginBloc>(() => LoginBloc(loginUseCase: getIt<LoginUseCase>()));
}
