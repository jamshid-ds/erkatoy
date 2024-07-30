part of 'create_account_bloc.dart';

sealed class CreateAccountEvent {}

final class OnChangeBirthDayDateAuthEvent extends CreateAccountEvent {
  OnChangeBirthDayDateAuthEvent(this.date);

  final DateTime date;
}

final class OnSelectGenderAuthEvent extends CreateAccountEvent {
  OnSelectGenderAuthEvent(this.gender);

  final String gender;
}

final class OnWeightEditingAuthEvent extends CreateAccountEvent {
  OnWeightEditingAuthEvent(this.value);

  final String value;
}
