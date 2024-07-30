part of 'create_account_bloc.dart';

class CreateAccountState extends Equatable {
  const CreateAccountState({
    this.birthdayDate,
    this.gender,
    this.weight = '',
  });

  final DateTime? birthdayDate;
  final String? gender;
  final String weight;

  CreateAccountState copyWith({
    DateTime? birthdayDate,
    String? gender,
    String? weight,
  }) =>
      CreateAccountState(
        birthdayDate: birthdayDate ?? this.birthdayDate,
        gender: gender ?? this.gender,
        weight: weight ?? this.weight,
      );

  @override
  List<Object?> get props => [birthdayDate, gender, weight];
}
