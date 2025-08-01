import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Events
abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class CheckConnectivity extends ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final ConnectivityResult result;

  const ConnectivityChanged(this.result);

  @override
  List<Object> get props => [result];
}
