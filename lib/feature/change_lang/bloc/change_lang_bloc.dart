import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erkatoy_afex_ai/core/provider/local/hive_local_storage.dart';

part 'change_lang_event.dart';
part 'change_lang_state.dart';

class ChangeLangBloc extends Bloc<ChangeLangEvent, ChangeLangState> {
  ChangeLangBloc({required this.localStorage}) : super(const ChangeLangState()) {
    on<OnChangeLocaleEvent>(_onChangeLocaleEvent);
  }

  final HiveLocalStorage localStorage;

  FutureOr<void> _onChangeLocaleEvent(
    OnChangeLocaleEvent event,
    Emitter<ChangeLangState> emit,
  ) async {
    // await localStorage
    //     .saveString(
    //         boxName: HiveConstants.localizationBoxName,
    //         key: HiveConstants.changedLocaleKey,
    //         value: event.locale)
    //     .whenComplete(() {
      emit(state.copyWith(changedLocale: event.locale));
    // });
  }
}
