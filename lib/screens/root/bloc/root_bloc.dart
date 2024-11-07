import 'package:bloc/bloc.dart';
import 'package:book_store_manager/repositories/services/admin_account/admin_account_service.dart';
import 'package:book_store_manager/repositories/services/authentication/authentication_service.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  late AdminAccountService _adminAccService;

  RootBloc() : super(RootState()) {
    _adminAccService = AdminAccountService();
    on<ValidateAuthEvent>(_onVerifyAuth);
    on<SignOutEvent>(_onSignOut);
  }

  _onVerifyAuth(ValidateAuthEvent event, Emitter emit) async {
    emit(RootState());

    String uid = event.uid;
    bool isAdmin = await Future.delayed(
      const Duration(seconds: 0),
      () => _adminAccService.checkIsAdminUsingId(uid),
    );

    emit(state.copyWith(isAdmin: isAdmin, isLoading: false));
  }

  _onSignOut(SignOutEvent event, Emitter emit) async {
    DialogUtils.showLoading();
    await AuthenticationService.signOut();
    DialogUtils.hideLoading();
  }
}
