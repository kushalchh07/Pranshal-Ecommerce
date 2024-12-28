import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  final String phoneNumber;

  RegisterSubmitted(
      {required this.username,
      required this.email,
      required this.password,
      required this.phoneNumber});

  @override
  List<Object?> get props => [username, email, password, phoneNumber];
}
