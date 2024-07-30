part of 'login_bloc.dart';

enum LoginStatus { pure, onSuccessful, onShowMessage }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.pure,
    this.obscureState = true,
    this.message,
    this.onLoading,
  });

  final LoginStatus status;
  final bool obscureState;
  final String? message;
  final bool? onLoading;

  LoginState copyWith({
    LoginStatus? status,
    bool? obscureState,
    String? message,
    bool? onLoading,
  }) =>
      LoginState(
        status: status ?? this.status,
        obscureState: obscureState ?? this.obscureState,
        message: message ?? this.message,
        onLoading: onLoading ?? this.onLoading,
      );

  @override
  List<Object?> get props => [status, obscureState, message, onLoading];
}
