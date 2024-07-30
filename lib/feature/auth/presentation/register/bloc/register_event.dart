part of 'register_bloc.dart';

sealed class RegisterEvent {}

final class OnObscurePressedRegisterEvent extends RegisterEvent {}

final class OnReObscurePressedRegisterEvent extends RegisterEvent {}

final class OnRegisterBtnPressedEvent extends RegisterEvent {
  OnRegisterBtnPressedEvent({required this.phoneNumber, required this.password});

  final String phoneNumber;
  final String password;
}
