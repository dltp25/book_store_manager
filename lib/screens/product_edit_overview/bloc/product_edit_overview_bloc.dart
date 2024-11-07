import 'package:bloc/bloc.dart';
import 'package:book_store_manager/constant/enum.dart';
import 'package:book_store_manager/models/book_type_model.dart';
import 'package:book_store_manager/models/product_model.dart';
import 'package:book_store_manager/repositories/product_repository.dart';
import 'package:book_store_manager/utils/date_time.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'product_edit_overview_event.dart';
part 'product_edit_overview_state.dart';

class ProductEditOverviewBloc
    extends Bloc<ProductEditOverviewEvent, ProductEditOverviewState> {
  final ProductRepository _productRepository;

  ProductEditOverviewBloc(this._productRepository)
      : super(const ProductEditOverviewState()) {
    on<InitialEvent>(_onInitial);
    on<UpdateTitleEvent>(_onUpdateTitle);
    on<UpdateAuthorEvent>(_onUpdateAuthor);
    on<UpdatePublisherEvent>(_onUpdatePublisher);
    on<UpdatePublishingYearEvent>(_onUpdatePublisingYear);
    on<UpdateBookTypeEvent>(_onUpdateBookType);
    on<UpdateDescriptionEvent>(_onUpdateDescription);
    on<ConfirmUpdateEvent>(_onConfirmUpdate);
  }

  _onInitial(InitialEvent event, Emitter emit) {
    emit(state.copyWith(
      productId: event.product.id,
      productTitle: event.product.title,
      author: event.product.author,
      publisher: event.product.publisher,
      publishingYear: event.product.publishingYear,
      description: event.product.description,
      type: BookTypesModel.codeToType[event.product.type],
      isLoading: false,
    ));
  }

  _onUpdateTitle(UpdateTitleEvent event, Emitter emit) {
    emit(state.copyWith(productTitle: event.newTitle, errTitle: ''));
  }

  _onUpdateAuthor(UpdateAuthorEvent event, Emitter emit) {
    emit(state.copyWith(author: event.newAuthor, errAuthor: ''));
  }

  _onUpdatePublisher(UpdatePublisherEvent event, Emitter emit) {
    emit(state.copyWith(publisher: event.newPublisher, errPublisher: ''));
  }

  _onUpdatePublisingYear(UpdatePublishingYearEvent event, Emitter emit) {
    String year = DateTimeUtils.getYear(event.newYear);
    emit(state.copyWith(publishingYear: year));
  }

  _onUpdateBookType(UpdateBookTypeEvent event, Emitter emit) {
    emit(state.copyWith(type: event.newType));
  }

  _onUpdateDescription(UpdateDescriptionEvent event, Emitter emit) {
    emit(state.copyWith(description: event.newDescription, errDescription: ''));
  }

  _onConfirmUpdate(ConfirmUpdateEvent event, Emitter emit) async {
    bool validData = true;

    if (state.productId.trim() == '') {
      Fluttertoast.showToast(
        msg: 'Lỗi không xác định',
        backgroundColor: Colors.red[400],
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    if (state.productTitle.trim() == '') {
      emit(state.copyWith(errTitle: 'Tên sản phẩm không được trống'));
      validData = false;
    }

    if (state.author.trim() == '') {
      emit(state.copyWith(errAuthor: 'Tên tác giả không được trống'));
      validData = false;
    }

    if (state.publisher.trim() == '') {
      emit(state.copyWith(errPublisher: 'Tên NXB không được trống'));
      validData = false;
    }

    if (state.description.trim() == '') {
      emit(state.copyWith(errDescription: 'Mô tả sản phẩm không được trống'));
      validData = false;
    }

    if (validData == true) {
      DialogUtils.showLoading();

      await _productRepository.updateOverviewProduct(
        productId: state.productId,
        title: state.productTitle,
        author: state.author,
        publisher: state.publisher,
        publishingYear: state.publishingYear,
        type: BookTypesModel.typeToCode[state.type]!,
        description: state.description,
      );

      DialogUtils.hideLoading();
      emit(UpdateSuccessfulState());
    }
  }
}
