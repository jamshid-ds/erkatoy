import 'package:flutter/material.dart';

enum FormZStatus {
  /// The form has not yet been submitted.
  initial,

  /// The form is in the process of being submitted.
  inProgress,

  /// The form has been submitted successfully.
  success,

  /// The form submission failed.
  failure,

  /// The form submission has been canceled.
  canceled,
}

extension FormZStatusExt on FormZStatus {
  /// Indicates whether the form has not yet been submitted.
  bool get isInitial => this == FormZStatus.initial;

  /// Indicates whether the form is in the process of being submitted.
  bool get isInProgress => this == FormZStatus.inProgress;

  /// Indicates whether the form has been submitted successfully.
  bool get isSuccess => this == FormZStatus.success;

  /// Indicates whether the form submission failed.
  bool get isFailure => this == FormZStatus.failure;

  /// Indicates whether the form submission has been canceled.
  bool get isCanceled => this == FormZStatus.canceled;

  /// Indicates whether the form is either in progress or has been submitted
  /// successfully.
  ///
  /// This is useful for showing a loading indicator or disabling the submit
  /// button to prevent duplicate submissions.
  bool get isInProgressOrSuccess => isInProgress || isSuccess;
}

@immutable
abstract class FormZInput<T, E> {
  const FormZInput._({required this.value, this.isPure = true});

  /// Constructor which create a `pure` [FormZInput] with a given value.
  const FormZInput.pure(T value) : this._(value: value);

  /// Constructor which create a `dirty` [FormZInput] with a given value.
  const FormZInput.dirty(T value) : this._(value: value, isPure: false);

  /// The value of the given [FormZInput].
  /// For example, if you have a `FormZInput` for `FirstName`,
  /// the value could be 'Joe'.
  final T value;

  /// For subsequent changes (in response to user input), the
  /// `FormZInput.dirty` constructor should be used to signify that
  /// the `FormZInput` has been manipulated.
  final bool isPure;

  /// Returns `true` if `validator` returns `null` for the
  /// current [FormZInput] value and `false` otherwise.
  bool get isValid => validator(value) == null;

  /// A value is invalid when the overridden `validator`
  /// returns an error (non-null value).
  bool get isNotValid => !isValid;

  /// Returns a validation error if the [FormZInput] is invalid.
  /// Returns `null` if the [FormZInput] is valid.
  E? get error => validator(value);

  /// The error to display if the [FormZInput] value
  /// is not valid and has been modified.
  E? get displayError => isPure ? null : error;

  /// A function that must return a validation error if the provided
  /// [value] is invalid and `null` otherwise.
  E? validator(T value);

  @override
  int get hashCode => Object.hashAll([value, isPure]);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is FormZInput<T, E> && other.value == value && other.isPure == isPure;
  }

  @override
  String toString() {
    return isPure
        ? '''FormZInput<$T, $E>.pure(value: $value, isValid: $isValid, error: $error)'''
        : '''FormZInput<$T, $E>.dirty(value: $value, isValid: $isValid, error: $error)''';
  }
}

/// Mixin for [FormzInput] that caches the [error] result of the [validator].
/// Use this mixin when implementations that make expensive computations are
/// used, such as those involving regular expressions.
mixin FormZInputErrorCacheMixin<T, E> on FormZInput<T, E> {
  late final E? _error = validator(value);

  @override
  E? get error => _error;

  @override
  bool get isValid => _error == null;
}

/// Class which contains methods that help manipulate and manage
/// validity of [FormzInput] instances.
class FormZ {
  FormZ._();

  /// Returns a [bool] given a list of [FormzInput] indicating whether
  /// the inputs are all valid.
  static bool validate(List<FormZInput<dynamic, dynamic>> inputs) {
    return inputs.every((input) => input.isValid);
  }

  /// Returns a [bool] given a list of [FormzInput] indicating whether
  /// all the inputs are pure.
  static bool isPure(List<FormZInput<dynamic, dynamic>> inputs) {
    return inputs.every((input) => input.isPure);
  }
}

mixin FormZMixin {
  /// Whether the [FormzInput] values are all valid.
  bool get isValid => FormZ.validate(inputs);

  /// Whether the [FormzInput] values are not all valid.
  bool get isNotValid => !isValid;

  /// Whether all of the [FormzInput] are pure.
  bool get isPure => FormZ.isPure(inputs);

  /// Whether at least one of the [FormzInput]s is dirty.
  bool get isDirty => !isPure;

  /// Returns all [FormzInput] instances.
  ///
  /// Override this and give it all [FormzInput]s in your class that should be
  /// validated automatically.
  List<FormZInput<dynamic, dynamic>> get inputs;
}
