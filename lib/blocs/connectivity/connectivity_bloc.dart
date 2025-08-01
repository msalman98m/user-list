import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'connectivity_event.dart';
import 'connectivity_state.dart';

// BLoC
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<CheckConnectivity>(_onCheckConnectivity);
    on<ConnectivityChanged>(_onConnectivityChanged);
    add(CheckConnectivity());
    _setupConnectivityStream();
  }

  void _setupConnectivityStream() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) {
        add(ConnectivityChanged(result));
      },
    );
  }

  void _updateConnectionStatus(
      ConnectivityResult result, Emitter<ConnectivityState> emit) {
    if (result == ConnectivityResult.none) {
      emit(ConnectivityDisconnected());
    } else {
      emit(ConnectivityConnected());
    }
  }

  Future<void> _onCheckConnectivity(
      CheckConnectivity event, Emitter<ConnectivityState> emit) async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result, emit);
    } catch (e) {
      emit(ConnectivityDisconnected());
    }
  }

  void _onConnectivityChanged(
      ConnectivityChanged event, Emitter<ConnectivityState> emit) {
    _updateConnectionStatus(event.result, emit);
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
