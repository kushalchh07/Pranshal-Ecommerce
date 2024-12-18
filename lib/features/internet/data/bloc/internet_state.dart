part of 'internet_bloc.dart';

abstract class InternetState {
  @override
  List<Object> get props => [];
}

class InternetInitial extends InternetState {}

class InternetConnected extends InternetState {}

class InternetDisconnected extends InternetState {}
