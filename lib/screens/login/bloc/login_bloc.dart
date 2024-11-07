import 'package:bloc/bloc.dart';
import '../../../repositories/services/authentication/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../utils/email_validator.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoggingEvent>(_onLogin);
    on<UpdateUserName>(_updateUsername);
    on<UpdatePassword>(_updatePassword);
  }

  _onLogin(LoginEvent event, Emitter emit) async {
    bool haveErr = false;

    if (state.userName.isEmpty) {
      emit(state.copyWith(errUsername: 'Vui lòng cung cấp Email'));
      haveErr = true;
    }

    if (state.password.isEmpty) {
      emit(state.copyWith(errPassword: 'Mật khẩu không được bỏ trống'));
      haveErr = true;
    }

    if (EmailValidator.validateEmail(state.userName) == false) {
      emit(state.copyWith(errUsername: 'Vui lòng nhập đúng định dạng Email'));
      haveErr = true;
    }

    if (haveErr == false) {
      emit(state.copyWith(isLoading: true));
      try {
        await AuthenticationService.signIn(state.userName, state.password);
      } on FirebaseAuthException catch (err) {
        if (err.code == 'invalid-email') {
          emit(state.copyWith(
              errUsername: 'Vui lòng nhập đúng định dạng Email'));
        }
        if (err.code == 'user-disabled') {
          emit(state.copyWith(errUsername: 'Tài khoản đã bị vô hiệu hóa'));
        }
        if (err.code == 'user-not-found' || err.code == 'wrong-password') {
          emit(state.copyWith(
              errUsername: 'Tài khoản hoặc mật khẩu không đúng'));
        }
      }

      emit(state.copyWith(isLoading: false));
    }
  }

  _updateUsername(UpdateUserName event, Emitter emit) {
    emit(state.copyWith(userName: event.userName, errUsername: ''));
  }

  _updatePassword(UpdatePassword event, Emitter emit) {
    emit(state.copyWith(password: event.password, errPassword: ''));
  }
}
