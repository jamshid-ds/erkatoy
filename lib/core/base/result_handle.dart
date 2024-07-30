import 'package:equatable/equatable.dart';

class Result<T> extends Equatable {
  const Result({this.data, this.errorMessage});

  final T? data;
  final String? errorMessage;

  @override
  List<Object?> get props => [data, errorMessage];
}
