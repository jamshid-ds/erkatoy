part of 'change_lang_bloc.dart';

class ChangeLangState extends Equatable {
  const ChangeLangState({this.changedLocale});

  final String? changedLocale;

  ChangeLangState copyWith({
    String? changedLocale,
  }) =>
      ChangeLangState(
        changedLocale: changedLocale ?? this.changedLocale,
      );

  @override
  List<Object?> get props => [changedLocale];
}
