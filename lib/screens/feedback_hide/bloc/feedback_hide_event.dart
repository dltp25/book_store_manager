part of 'feedback_hide_bloc.dart';

sealed class FeedbackHideEvent extends Equatable {
  const FeedbackHideEvent();

  @override
  List<Object> get props => [];
}

class FeedbackHideLoadEvent extends FeedbackHideEvent {}

class FeedbackUnHideEvent extends FeedbackHideEvent {
  final String feedbackId;

  const FeedbackUnHideEvent({required this.feedbackId});
}
