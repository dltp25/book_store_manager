import 'package:bloc/bloc.dart';
import 'package:book_store_manager/models/user_report_model.dart';
import 'package:book_store_manager/repositories/user_report_repository.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';
import 'package:equatable/equatable.dart';

part 'user_report_event.dart';
part 'user_report_state.dart';

class UserReportBloc extends Bloc<UserReportEvent, UserReportState> {
  final UserReportRepository _reportRepository;

  UserReportBloc(this._reportRepository) : super(const UserReportState()) {
    on<InitialEvent>(_onInitial);
    on<HideFeedbackEvent>(_onHideFeedback);
    on<ReadReportEvent>(_onReadReport);
  }

  _onInitial(InitialEvent event, Emitter emit) async {
    final List<UserReportModel> reports =
        await _reportRepository.getUserReport(0);

    emit(state.copyWith(isLoading: false, reports: reports));
  }

  _onHideFeedback(HideFeedbackEvent event, Emitter emit) async {
    DialogUtils.showLoading();
    await _reportRepository.hideFeedback(event.feedbackId);

    List<UserReportModel> temp = List.from(state.reports);
    temp.removeWhere((element) => element.feedbackId == event.feedbackId);
    emit(state.copyWith(reports: temp));

    DialogUtils.hideLoading();
  }

  _onReadReport(ReadReportEvent event, Emitter emit) async {
    DialogUtils.showLoading();
    await _reportRepository.readReport(event.reportId);

    List<UserReportModel> temp = List.from(state.reports);
    temp.removeWhere((element) => element.id == event.reportId);
    emit(state.copyWith(reports: temp));
    DialogUtils.hideLoading();
  }
}
