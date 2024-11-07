import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store_manager/constant/enum.dart';
import 'package:book_store_manager/models/feedback_model.dart';
import 'package:book_store_manager/repositories/feedback_repository.dart';
import 'package:book_store_manager/repositories/product_repository.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';
import 'package:book_store_manager/utils/enum_convert.dart';
import 'package:equatable/equatable.dart';

import '../../../models/product_model.dart';

part 'product_feedback_event.dart';
part 'product_feedback_state.dart';

class ProductFeedbackBloc
    extends Bloc<ProductFeedbackEvent, ProductFeedbackState> {
  final ProductRepository _productRepository;
  final FeedbackRepository _feedbackRepository;

  ProductFeedbackBloc(this._productRepository, this._feedbackRepository)
      : super(const ProductFeedbackState()) {
    on<ProductFeedbackLoading>(_onLoading);
    on<UpdateFeedbackViewType>(_onUpdateViewType);
    on<ProductHideFeedback>(_onProductHideFeedback);
  }

  _onLoading(ProductFeedbackLoading event, Emitter emit) async {
    final futureGroup = await Future.wait([
      _productRepository.getProduct(event.productId),
      _feedbackRepository.getFeedbackOfProduct(event.productId),
    ]);

    ProductModel productModel = futureGroup[0] as ProductModel;
    List<FeedbackModel> feedbacks = futureGroup[1] as List<FeedbackModel>;
    FeedbackViewType viewType = FeedbackViewType.all;
    List<FeedbackModel> showedFeedbacks = List.from(feedbacks);

    showedFeedbacks.sort((a, b) => b.dateSubmit.compareTo(a.dateSubmit));

    emit(state.copyWith(
      isLoading: false,
      feedbacks: feedbacks,
      showedFeedbacks: showedFeedbacks,
      product: productModel,
      viewType: viewType,
    ));
  }

  _onUpdateViewType(UpdateFeedbackViewType event, Emitter emit) {
    if (event.type != state.viewType) {
      emit(state.copyWith(viewType: event.type));
      int rating = EnumConvert.feedbackToInt(event.type);
      List<FeedbackModel> newShowed;

      if (rating == 0) {
        newShowed = List.from(state.feedbacks);
      } else {
        newShowed = state.feedbacks
            .where((element) => element.rating == rating)
            .toList();
      }
      newShowed.sort((a, b) => b.dateSubmit.compareTo(a.dateSubmit));

      emit(state.copyWith(showedFeedbacks: newShowed));
    }
  }

  _onProductHideFeedback(ProductHideFeedback event, Emitter emit) async {
    DialogUtils.showLoading();

    await _feedbackRepository.hideFeedback(event.feedbackId, true);
    int showedIndex = state.showedFeedbacks
        .indexWhere((element) => element.id == event.feedbackId);
    int index =
        state.feedbacks.indexWhere((element) => element.id == event.feedbackId);

    List<FeedbackModel> newFeedbacks = List.from(state.feedbacks);
    List<FeedbackModel> newShowed = List.from(state.showedFeedbacks);

    if (index != -1) {
      newFeedbacks.removeAt(index);
    }

    if (showedIndex != -1) {
      newShowed.removeAt(showedIndex);
    }

    emit(state.copyWith(showedFeedbacks: newShowed, feedbacks: newFeedbacks));
    DialogUtils.hideLoading();
  }
}
