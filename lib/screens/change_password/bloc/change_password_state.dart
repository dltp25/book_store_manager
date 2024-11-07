part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  final String newPass;
  final String confirmPass;

  final String newErr;
  final String confirmErr;

  const ChangePasswordState({
    this.newPass = '',
    this.confirmPass = '',
    this.newErr = '',
    this.confirmErr = '',
  });

  @override
  List<Object> get props => [newPass, confirmPass, newErr, confirmErr];

  ChangePasswordState copyWith({
    String? newPass,
    String? confirmPass,
    String? newErr,
    String? confirmErr,
  }) {
    return ChangePasswordState(
      newPass: newPass ?? this.newPass,
      confirmPass: confirmPass ?? this.confirmPass,
      newErr: newErr ?? this.newErr,
      confirmErr: confirmErr ?? this.confirmErr,
    );
  }
}

class ChangePasswordSuccessState extends ChangePasswordState {}
