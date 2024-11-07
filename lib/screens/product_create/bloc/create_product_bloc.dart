import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:book_store_manager/constant/enum.dart';
import 'package:book_store_manager/models/book_type_model.dart';
import 'package:book_store_manager/models/product_create_model.dart';
import 'package:book_store_manager/repositories/product_repository.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/utils/date_time.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  final ProductRepository _prdRepository;

  CreateProductBloc(this._prdRepository) : super(const CreateProductState()) {
    on<UpdateTitleEvent>(_onUpdateTitle);
    on<UpdateAuthorEvent>(_onUpdateAuthor);
    on<UpdatePublisherEvent>(_onUpdatePublisher);
    on<UpdatePublishingYearEvent>(_onUpdatePublishingYear);
    on<UpdateBookTypeEvent>(_onUpdateBookType);
    on<AddImageEvent>(_onAddImages);
    on<RemoveImageEvent>(_onRemoveImage);
    on<UpdateDescriptionEvent>(_onUpdateDescription);
    on<UpdatePriceEvent>(_onUpdatePrice);
    on<UpdateDiscountEvent>(_onUpdateDiscount);
    on<ConfirmCreateEvent>(_onCreateProduct);
  }

  _onUpdateTitle(UpdateTitleEvent event, Emitter emit) {
    emit(state.copyWith(productTitle: event.newTitle, titleErr: ''));
  }

  _onUpdateAuthor(UpdateAuthorEvent event, Emitter emit) {
    emit(state.copyWith(author: event.newAuthor, authorErr: ''));
  }

  _onUpdatePublisher(UpdatePublisherEvent event, Emitter emit) {
    emit(state.copyWith(publisher: event.newPublisher, publisherErr: ''));
  }

  _onUpdatePublishingYear(UpdatePublishingYearEvent event, Emitter emit) {
    String cvYear = DateTimeUtils.getYear(event.newYear);
    emit(state.copyWith(publishingYear: cvYear));
  }

  _onUpdateBookType(UpdateBookTypeEvent event, Emitter emit) {
    emit(state.copyWith(type: event.newType));
  }

  _onAddImages(AddImageEvent event, Emitter emit) {
    List<File> current = List.from(state.images);
    current.addAll(event.newImages);

    emit(state.copyWith(images: current, imageErr: ''));
  }

  _onRemoveImage(RemoveImageEvent event, Emitter emit) {
    List<File> current = List.from(state.images);
    current.remove(event.removedImage);

    emit(state.copyWith(images: current));
  }

  _onUpdateDescription(UpdateDescriptionEvent event, Emitter emit) {
    emit(state.copyWith(description: event.newDescription, descriptionErr: ''));
  }

  _onUpdatePrice(UpdatePriceEvent event, Emitter emit) {
    double price;
    if (event.newPrice.isEmpty) {
      price = 0;
    } else {
      price = double.parse(event.newPrice);
    }

    emit(state.copyWith(price: price, priceErr: ''));
  }

  _onUpdateDiscount(UpdateDiscountEvent event, Emitter emit) {
    double discount;
    if (event.newDiscount.isEmpty) {
      discount = 0;
    } else {
      discount = double.parse(event.newDiscount);
    }
    emit(state.copyWith(discount: discount, discountErr: ''));
  }

  _onCreateProduct(ConfirmCreateEvent event, Emitter emit) async {
    bool hasErr = false;

    if (state.productTitle.trim().isEmpty) {
      hasErr = true;
      emit(state.copyWith(titleErr: 'Tên sách không được bỏ trống'));
    }

    if (state.author.trim().isEmpty) {
      hasErr = true;
      emit(state.copyWith(authorErr: 'Tác giả không được bỏ trống'));
    }

    if (state.publisher.trim().isEmpty) {
      hasErr = true;
      emit(state.copyWith(publisherErr: 'NXB không được bỏ trống'));
    }

    if (state.description.trim().isEmpty) {
      hasErr = true;
      emit(state.copyWith(descriptionErr: 'Mô tả không đươc bỏ trống'));
    }

    if (state.images.isEmpty) {
      hasErr = true;
      emit(state.copyWith(imageErr: 'Hình ảnh sản phẩm là bắt buộc'));
    }

    if (state.price == 0) {
      hasErr = true;
      emit(state.copyWith(priceErr: 'Vui lòng cung cấp giá sản phẩm'));
    }

    if (hasErr == false) {
      DialogUtils.showLoading();

      ProductCreateModel product = ProductCreateModel(
        title: state.productTitle.trim(),
        author: state.author.trim(),
        publisher: state.publisher.trim(),
        publishingYear: state.publishingYear,
        type: BookTypesModel.typeToCode[state.type]!,
        description: state.description.trim(),
        price: state.price,
        discount: state.discount / 100,
      );

      await _prdRepository.createNewProduct(product, state.images);

      DialogUtils.hideLoading();
      Fluttertoast.showToast(
        msg: 'Thêm sản phẩm mới thành công',
        backgroundColor: AppColors.successColor,
        textColor: AppColors.contentColor,
      );

      emit(CreateSuccessState());
    }
  }
}
