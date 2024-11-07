import 'package:bloc/bloc.dart';
import 'package:book_store_manager/repositories/services/authentication/authentication_service.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(const ChangePasswordState()) {
    on<UpdateNewPassword>(_onUpdateNew);
    on<UpdateConfirmPassword>(_onUpdateConfirm);
    on<ConfirmChangePassword>(_onChange);
  }

  _onUpdateNew(UpdateNewPassword event, Emitter emit) {
    emit(state.copyWith(newPass: event.newPass, newErr: ''));
  }

  _onUpdateConfirm(UpdateConfirmPassword event, Emitter emit) {
    emit(state.copyWith(confirmPass: event.confirmPass, confirmErr: ''));
  }

  _onChange(ConfirmChangePassword event, Emitter emit) async {
    bool hasErr = false;

    if (state.newPass.isEmpty) {
      emit(state.copyWith(newErr: 'Vui lòng nhập mật khẩu mới'));
      hasErr = true;
    }

    if (state.confirmPass.isEmpty) {
      emit(state.copyWith(confirmErr: 'Vui lòng xác nhận mật khẩu mới'));
      hasErr = true;
    }

    if (state.confirmPass != state.newPass) {
      emit(state.copyWith(confirmErr: 'Mật khẩu xác nhận không khớp'));
      hasErr = true;
    }

    if (hasErr == false) {
      DialogUtils.showLoading();
      try {
        await AuthenticationService.updatePassword(state.newPass).then((value) {
          DialogUtils.hideLoading();
          emit(ChangePasswordSuccessState());
          Fluttertoast.showToast(msg: 'Thay đổi mật khẩu thành công');
        });
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoading();
        if (e.code == 'weak-password') {
          emit(state.copyWith(newErr: 'Mật khẩu không đủ mạnh'));
        }
        if (e.code == 'requires-recent-login') {
          emit(
            state.copyWith(
              newErr:
                  'Tài khoản của bạn đã được đăng nhập quá lâu. Vui lòng đăng nhập lại để có thể thay đổi mật khẩu',
            ),
          );
        }
      }
    }
  }
}
