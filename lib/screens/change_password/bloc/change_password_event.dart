part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class UpdateNewPassword extends ChangePasswordEvent {
  final String newPass;

  const UpdateNewPassword({required this.newPass});
}

class UpdateConfirmPassword extends ChangePasswordEvent {
  final String confirmPass;

  const UpdateConfirmPassword({required this.confirmPass});
}

class ConfirmChangePassword extends ChangePasswordEvent {}
