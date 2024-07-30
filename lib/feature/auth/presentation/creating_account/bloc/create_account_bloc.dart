import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erkatoy_afex_ai/feature/auth/domain/use_case/login_use_case.dart';
import 'package:erkatoy_afex_ai/feature/auth/domain/use_case/send_child_info_use_case.dart';

part 'create_account_event.dart';
part 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  CreateAccountBloc({
    required this.loginUseCase,
    required this.sendChildInfoUseCase,
  }) : super(const CreateAccountState()) {
    on<OnChangeBirthDayDateAuthEvent>(_onChangeBirthDayDateEvent);
    on<OnSelectGenderAuthEvent>(_onSelectGenderAuthEvent);
    on<OnWeightEditingAuthEvent>(_onWeightEditingAuthEvent);
  }

  final LoginUseCase loginUseCase;
  final SendChildInfoUseCase sendChildInfoUseCase;

  FutureOr<void> _onChangeBirthDayDateEvent(
    OnChangeBirthDayDateAuthEvent event,
    Emitter<CreateAccountState> emit,
  ) {
    emit(state.copyWith(birthdayDate: event.date));
  }

  FutureOr<void> _onSelectGenderAuthEvent(
    OnSelectGenderAuthEvent event,
    Emitter<CreateAccountState> emit,
  ) {
    emit(state.copyWith(gender: event.gender));
  }

  FutureOr<void> _onWeightEditingAuthEvent(
    OnWeightEditingAuthEvent event,
    Emitter<CreateAccountState> emit,
  ) {
    emit(state.copyWith(weight: event.value));
  }
}
