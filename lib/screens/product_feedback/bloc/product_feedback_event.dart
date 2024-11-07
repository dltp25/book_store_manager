part of 'product_feedback_bloc.dart';

sealed class ProductFeedbackEvent extends Equatable {
  const ProductFeedbackEvent();

  @override
  List<Object> get props => [];
}

class ProductFeedbackLoading extends ProductFeedbackEvent {
  final String productId;

  const ProductFeedbackLoading({required this.productId});
}

class UpdateFeedbackViewType extends ProductFeedbackEvent {
  final FeedbackViewType type;

  const UpdateFeedbackViewType({required this.type});
}

class ProductHideFeedback extends ProductFeedbackEvent {
  final String feedbackId;

  const ProductHideFeedback({required this.feedbackId});
}
