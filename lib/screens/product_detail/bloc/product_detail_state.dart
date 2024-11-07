part of 'product_detail_bloc.dart';

class ProductDetailState extends Equatable {
  final bool isLoading;
  final ProductModel? productData;
  final bool haveChange;

  const ProductDetailState({
    this.isLoading = true,
    this.productData,
    this.haveChange = false,
  });

  @override
  List<Object?> get props => [isLoading, productData, haveChange];

  ProductDetailState copyWith({
    bool? isLoading,
    ProductModel? productData,
    bool? haveChange,
  }) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      productData: productData ?? this.productData,
      haveChange: haveChange ?? this.haveChange,
    );
  }
}
