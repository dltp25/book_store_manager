part of 'root_bloc.dart';

abstract class RootEvent {}

class ValidateAuthEvent extends RootEvent {
  final String uid;

  ValidateAuthEvent({required this.uid});
}

class SignOutEvent extends RootEvent {}
