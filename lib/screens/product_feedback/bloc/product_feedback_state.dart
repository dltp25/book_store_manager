part of 'product_feedback_bloc.dart';

class ProductFeedbackState extends Equatable {
  final bool isLoading;
  final ProductModel? product;
  final FeedbackViewType? viewType;
  final List<FeedbackModel> feedbacks;
  final List<FeedbackModel> showedFeedbacks;

  const ProductFeedbackState({
    this.isLoading = true,
    this.product,
    this.viewType,
    this.feedbacks = const [],
    this.showedFeedbacks = const [],
  });

  @override
  List<Object?> get props => [
        isLoading,
        product,
        viewType,
        feedbacks,
        showedFeedbacks,
      ];

  ProductFeedbackState copyWith({
    bool? isLoading,
    ProductModel? product,
    FeedbackViewType? viewType,
    List<FeedbackModel>? feedbacks,
    List<FeedbackModel>? showedFeedbacks,
  }) {
    return ProductFeedbackState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      viewType: viewType ?? this.viewType,
      feedbacks: feedbacks ?? this.feedbacks,
      showedFeedbacks: showedFeedbacks ?? this.showedFeedbacks,
    );
  }
}
