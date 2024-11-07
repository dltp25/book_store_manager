part of 'feedback_hide_bloc.dart';

class FeedbackHideState extends Equatable {
  final bool isLoading;
  final List<FeedbackModel> feedbacks;

  const FeedbackHideState({
    this.isLoading = true,
    this.feedbacks = const [],
  });

  @override
  List<Object> get props => [isLoading, feedbacks];

  FeedbackHideState copyWith({
    bool? isLoading,
    List<FeedbackModel>? feedbacks,
  }) {
    return FeedbackHideState(
      isLoading: isLoading ?? this.isLoading,
      feedbacks: feedbacks ?? this.feedbacks,
    );
  }
}
