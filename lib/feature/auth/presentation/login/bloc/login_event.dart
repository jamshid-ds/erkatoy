part of 'login_bloc.dart';

sealed class LoginEvent {}

final class OnObscurePressedLoginEvent extends LoginEvent {}

final class OnLoginBtnPressedEvent extends LoginEvent {
  OnLoginBtnPressedEvent({required this.phoneNumber, required this.password});

  final String phoneNumber;
  final String password;
}
