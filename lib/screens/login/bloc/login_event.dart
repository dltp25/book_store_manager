part of 'login_bloc.dart';

abstract class LoginEvent {}

class UpdateUserName extends LoginEvent {
  final String userName;

  UpdateUserName({required this.userName});
}

class UpdatePassword extends LoginEvent {
  final String password;

  UpdatePassword({required this.password});
}

class LoggingEvent extends LoginEvent {}
