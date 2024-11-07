part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class UpdateEmailEvent extends ForgotPasswordEvent {
  final String email;

  const UpdateEmailEvent({required this.email});
}

class SendEmailResetPassword extends ForgotPasswordEvent {}
