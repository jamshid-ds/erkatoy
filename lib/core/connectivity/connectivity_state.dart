part of 'connectivity_cubit.dart';

enum ConnectivityStatus { pure, connectionFailed, connectionRestored }

class ConnectivityState extends Equatable {
  const ConnectivityState({
    this.status = ConnectivityStatus.pure,
    this.isDialogShows = false,
  });

  final ConnectivityStatus status;
  final bool isDialogShows;

  ConnectivityState copyWith({
    ConnectivityStatus? status,
    bool? isDialogShows,
  }) =>
      ConnectivityState(
        status: status ?? this.status,
        isDialogShows: isDialogShows ?? this.isDialogShows,
      );

  @override
  List<Object?> get props => [status, isDialogShows];
}
