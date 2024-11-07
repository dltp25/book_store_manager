import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/services/admin_account/admin_account_service.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  late AdminAccountService _adminAccService;

  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    _adminAccService = AdminAccountService();

    on<UpdateEmailEvent>(_onUpdateEmail);
    on<SendEmailResetPassword>(_onSendMail);
  }

  _onUpdateEmail(UpdateEmailEvent event, Emitter emit) {
    emit(state.copyWith(email: event.email, err: '', isSuccess: false));
  }

  _onSendMail(SendEmailResetPassword event, Emitter emit) async {}
}
