part of 'manage_product_bloc.dart';

class ManageProductState extends Equatable {
  final bool isLoading;
  final List<ProductModel> products;
  final List<ProductModel> showedProducts;
  final List<String> currentShowTypes;
  final bool? inStockDescending;
  final String searchQuery;

  const ManageProductState({
    this.isLoading = true,
    this.products = const [],
    this.showedProducts = const [],
    this.inStockDescending,
    this.currentShowTypes = const [],
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [
        isLoading,
        products,
        showedProducts,
        currentShowTypes,
        inStockDescending
      ];

  ManageProductState copyWith({
    bool? isLoading,
    List<ProductModel>? products,
    List<ProductModel>? showedProducts,
    List<String>? currentShowTypes,
    bool? inStockDescending,
    bool clearInStockDescending = false,
    String? searchQuery,
  }) {
    return ManageProductState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      showedProducts: showedProducts ?? this.showedProducts,
      currentShowTypes: currentShowTypes ?? this.currentShowTypes,
      searchQuery: searchQuery ?? this.searchQuery,
      inStockDescending: clearInStockDescending
          ? null
          : inStockDescending ?? this.inStockDescending,
    );
  }
}
