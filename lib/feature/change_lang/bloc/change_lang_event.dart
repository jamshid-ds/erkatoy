part of 'change_lang_bloc.dart';

sealed class ChangeLangEvent {}

class OnChangeLocaleEvent extends ChangeLangEvent {
  OnChangeLocaleEvent(this.locale);

  final String locale;
}
