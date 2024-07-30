part of 'register_bloc.dart';

enum RegisterStatus { pure, onSuccessful, onShowMessage }

class RegisterState extends Equatable {
  const RegisterState({
    this.status = RegisterStatus.pure,
    this.obscureState = true,
    this.reObscureState = true,
    this.message,
    this.onLoading,
  });

  final RegisterStatus status;
  final bool obscureState;
  final bool reObscureState;
  final String? message;
  final bool? onLoading;

  RegisterState copyWith({
    RegisterStatus? status,
    bool? obscureState,
    bool? reObscureState,
    String? message,
    bool? onLoading,
  }) =>
      RegisterState(
        status: status ?? this.status,
        obscureState: obscureState ?? this.obscureState,
        reObscureState: reObscureState ?? this.reObscureState,
        message: message ?? this.message,
        onLoading: onLoading ?? this.onLoading,
      );

  @override
  List<Object?> get props => [status, obscureState, reObscureState, message, onLoading];
}
