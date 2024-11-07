import 'package:bloc/bloc.dart';
import 'package:book_store_manager/models/feedback_model.dart';
import 'package:book_store_manager/repositories/feedback_repository.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';
import 'package:equatable/equatable.dart';

part 'feedback_hide_event.dart';
part 'feedback_hide_state.dart';

class FeedbackHideBloc extends Bloc<FeedbackHideEvent, FeedbackHideState> {
  final FeedbackRepository _feedbackRepository;

  FeedbackHideBloc(this._feedbackRepository)
      : super(const FeedbackHideState()) {
    on<FeedbackHideLoadEvent>(_onLoad);
    on<FeedbackUnHideEvent>(_onUnHide);
  }

  _onLoad(FeedbackHideLoadEvent event, Emitter emit) async {
    List<FeedbackModel> feedbacks = await _feedbackRepository.getHideFeedback();
    feedbacks.sort((a, b) => b.dateSubmit.compareTo(a.dateSubmit));

    emit(state.copyWith(isLoading: false, feedbacks: feedbacks));
  }

  _onUnHide(FeedbackUnHideEvent event, Emitter emit) async {
    DialogUtils.showLoading();
    await _feedbackRepository.hideFeedback(event.feedbackId, false);

    int index =
        state.feedbacks.indexWhere((element) => element.id == event.feedbackId);
    if (index != -1) {
      List<FeedbackModel> newState = List.from(state.feedbacks);
      newState.removeAt(index);

      emit(state.copyWith(feedbacks: newState));
    }
    DialogUtils.hideLoading();
  }
}
