part of 'create_import_product_bloc.dart';

class CreateImportProductState extends Equatable {
  final Map<ProductLiteModel, int> products;
  final List<ProductLiteModel> allProduct;
  final bool isLoading;

  const CreateImportProductState({
    this.products = const {},
    this.allProduct = const [],
    this.isLoading = true,
  });

  @override
  List<Object> get props => [products, allProduct, isLoading];

  CreateImportProductState copyWith({
    Map<ProductLiteModel, int>? products,
    List<ProductLiteModel>? allProduct,
    bool? isLoading,
  }) {
    return CreateImportProductState(
      products: products ?? this.products,
      allProduct: allProduct ?? this.allProduct,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ImportCompleteState extends CreateImportProductState {}
