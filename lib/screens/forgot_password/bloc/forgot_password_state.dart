part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final String email;
  final String err;
  final bool isSuccess;

  const ForgotPasswordState({
    this.email = '',
    this.err = '',
    this.isSuccess = false,
  });

  @override
  List<Object> get props => [email, err, isSuccess];

  ForgotPasswordState copyWith({String? email, String? err, bool? isSuccess}) {
    return ForgotPasswordState(
      email: email ?? this.email,
      err: err ?? this.err,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
