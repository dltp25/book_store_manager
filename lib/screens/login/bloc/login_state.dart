part of 'login_bloc.dart';

class LoginState {
  final bool isLoading;
  final String userName;
  final String password;
  final String errUsername;
  final String errPassword;

  LoginState({
    this.isLoading = false,
    this.userName = "",
    this.password = "",
    this.errUsername = "",
    this.errPassword = "",
  });

  LoginState copyWith({
    bool? isLoading,
    String? userName,
    String? password,
    String? errUsername,
    String? errPassword,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errPassword: errPassword ?? this.errPassword,
      errUsername: errUsername ?? this.errUsername,
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }
}
