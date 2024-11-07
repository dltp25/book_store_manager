import 'package:bloc/bloc.dart';
import 'package:book_store_manager/models/product_model.dart';
import 'package:book_store_manager/repositories/product_repository.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:diacritic/diacritic.dart';

part 'manage_product_event.dart';
part 'manage_product_state.dart';

class ManageProductBloc extends Bloc<ManageProductEvent, ManageProductState> {
  final ProductRepository _productRepo;

  ManageProductBloc(this._productRepo) : super(const ManageProductState()) {
    on<ManageProductLoading>(_onLoading);
    on<SearchProductEvent>(_onSearching);
    on<FilterProductEvent>(_onFilter);
  }

  _onLoading(ManageProductLoading event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    final List<ProductModel> products = await _productRepo.getAllProduct();

    emit(state.copyWith(
      isLoading: false,
      products: products,
      showedProducts: products,
    ));
  }

  _onSearching(SearchProductEvent event, Emitter emit) {
    List<ProductModel> newShowedProducts = [];

    if (state.currentShowTypes.isNotEmpty) {
      newShowedProducts =
          filterProductsByTypes(state.products, state.currentShowTypes);
    } else {
      newShowedProducts = List.from(state.products);
    }

    newShowedProducts = searchProductByQuery(newShowedProducts, event.query);

    if (event.query.isNotEmpty) {
      newShowedProducts = searchProductByQuery(newShowedProducts, event.query);
    }

    if (state.inStockDescending == true) {
      newShowedProducts.sort((a, b) => b.stock.compareTo(a.stock));
    } else if (state.inStockDescending == false) {
      newShowedProducts.sort((a, b) => a.stock.compareTo(b.stock));
    }

    emit(state.copyWith(
      showedProducts: newShowedProducts,
      searchQuery: event.query.isEmpty ? '' : event.query,
    ));
  }

  _onFilter(FilterProductEvent event, Emitter emit) {
    DialogUtils.showLoading();
    if (event.bookType.isNotEmpty || event.inStockDescending != null) {
      List<ProductModel> newShowedProduct = [];

      if (event.bookType.isNotEmpty) {
        newShowedProduct =
            filterProductsByTypes(state.products, event.bookType);
      } else {
        newShowedProduct = List.from(state.products);
      }

      if (state.searchQuery.isNotEmpty) {
        newShowedProduct =
            searchProductByQuery(newShowedProduct, state.searchQuery);
      }

      if (event.inStockDescending == true) {
        newShowedProduct.sort((a, b) => b.stock.compareTo(a.stock));
      } else if (event.inStockDescending == false) {
        newShowedProduct.sort((a, b) => a.stock.compareTo(b.stock));
      }

      emit(state.copyWith(
        showedProducts: newShowedProduct,
        currentShowTypes: event.bookType,
        inStockDescending: event.inStockDescending,
        clearInStockDescending: event.inStockDescending == null,
      ));
    } else {
      emit(state.copyWith(
        currentShowTypes: [],
        inStockDescending: null,
        clearInStockDescending: true,
      ));

      add(SearchProductEvent(query: state.searchQuery));
    }
    DialogUtils.hideLoading();
  }

  List<ProductModel> filterProductsByTypes(
      List<ProductModel> products, List<String> bookTypes) {
    return products
        .where((product) => bookTypes.contains(product.type))
        .toList();
  }

  List<ProductModel> searchProductByQuery(
      List<ProductModel> products, String query) {
    String normalizedQuery = removeDiacritics(query.toLowerCase());
    List<ProductModel> newShowedProducts = [];

    for (var ele in products) {
      String normalizedSearchKey =
          removeDiacritics(ele.searchKey.toLowerCase());
      if (normalizedSearchKey.contains(normalizedQuery)) {
        newShowedProducts.add(ele);
      }
    }
    return newShowedProducts;
  }
}
