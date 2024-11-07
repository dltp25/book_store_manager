part of 'feedback_bloc.dart';

class FeedbackState extends Equatable {
  final bool isLoading;
  final List<FeedbackModel> feedback;
  final ManageFeedbackType? type;
  final DateTime? selectedMonth;

  const FeedbackState({
    this.isLoading = true,
    this.feedback = const [],
    this.type,
    this.selectedMonth,
  });

  @override
  List<Object?> get props => [
        isLoading,
        feedback,
        type,
        selectedMonth,
      ];

  FeedbackState copyWith({
    bool? isLoading,
    List<FeedbackModel>? feedback,
    ManageFeedbackType? type,
    DateTime? selectedMonth,
  }) {
    return FeedbackState(
      isLoading: isLoading ?? this.isLoading,
      feedback: feedback ?? this.feedback,
      type: type ?? this.type,
      selectedMonth: selectedMonth ?? this.selectedMonth,
    );
  }
}
