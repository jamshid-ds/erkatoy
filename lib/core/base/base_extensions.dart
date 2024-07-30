import 'package:erkatoy_afex_ai/core/connectivity/connectivity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension StringExtensions on String {
  bool get phoneNumbIsValid {
    final RegExp regex = RegExp(r'^\+998\d{9}$');
    return regex.hasMatch(this);
  }
}

extension BuildContextExtensions on BuildContext {
  bool get getConnectivity =>
      read<ConnectivityCubit>().state.status != ConnectivityStatus.connectionFailed;
}
