import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final Map<String, dynamic> response;

  RegisterSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
