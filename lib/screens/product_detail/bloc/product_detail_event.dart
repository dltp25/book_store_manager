part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends ProductDetailEvent {
  final String productId;
  final bool callAfterDataChange;

  const InitialEvent({
    required this.productId,
    required this.callAfterDataChange,
  });
}

class UpdatePriceAndDiscountEvent extends ProductDetailEvent {
  final double price;
  final double discount;

  const UpdatePriceAndDiscountEvent({
    required this.price,
    required this.discount,
  });
}
