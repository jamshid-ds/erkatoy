import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:erkatoy_afex_ai/core/base/base_functions.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(const ConnectivityState());

  late final StreamSubscription _connectivitySubscription;

  Connectivity get _connectivity => Connectivity();

  void onDialogOpen(bool isDialogOpen) {
    emit(state.copyWith(isDialogShows: isDialogOpen));
  }

  void observeConnectivity() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      emit(state.copyWith(
        status: result.last == ConnectivityResult.none
            ? ConnectivityStatus.connectionFailed
            : ConnectivityStatus.connectionRestored,
      ));
      printOnDebug("on cubit: ${state.status}");
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
