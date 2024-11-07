import 'package:bloc/bloc.dart';
import 'package:book_store_manager/models/product_model.dart';
import 'package:book_store_manager/repositories/import_repository.dart';
import 'package:book_store_manager/repositories/product_repository.dart';
import 'package:book_store_manager/themes/colors.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'create_import_product_event.dart';
part 'create_import_product_state.dart';

class CreateImportProductBloc
    extends Bloc<CreateImportProductEvent, CreateImportProductState> {
  final ProductRepository _productRepository;
  final ImportRepository _importRepository;

  CreateImportProductBloc(this._productRepository, this._importRepository)
      : super(const CreateImportProductState()) {
    on<InitialEvent>(_onInitial);
    on<AddProductEvent>(_onAddProduct);
    on<RemoveProductEvent>(_onRemoveProduct);
    on<UpdateProductQuantityEvent>(_onUpdateQuantity);
    on<ConfirmImportEvent>(_onConfirmImport);
  }

  _onInitial(InitialEvent event, Emitter emit) async {
    List<ProductLiteModel> allProducts =
        await _productRepository.getAllLiteProduct();

    emit(state.copyWith(allProduct: allProducts, isLoading: false));
  }

  _onAddProduct(AddProductEvent event, Emitter emit) {
    Map<ProductLiteModel, int> current = Map.from(state.products);

    current.addAll({event.product: 1});
    emit(state.copyWith(products: current));
  }

  _onRemoveProduct(RemoveProductEvent event, Emitter emit) {
    Map<ProductLiteModel, int> current = Map.from(state.products);

    current.remove(event.product);
    emit(state.copyWith(products: current));
  }

  _onUpdateQuantity(UpdateProductQuantityEvent event, Emitter emit) {
    Map<ProductLiteModel, int> current = Map.from(state.products);

    current[event.product] = event.quantity;
    emit(state.copyWith(products: current));
  }

  _onConfirmImport(ConfirmImportEvent event, Emitter emit) async {
    DialogUtils.showLoading();

    try {
      await _productRepository.importProduct(state.products);
      await _importRepository.saveImportHistory(state.products);
      DialogUtils.hideLoading();
      Fluttertoast.showToast(
        msg: 'Nhập kho thành công',
        backgroundColor: AppColors.successColor,
        textColor: AppColors.contentColor,
      );
      emit(ImportCompleteState());
    } catch (e) {
      DialogUtils.hideLoading();
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: AppColors.errorColor,
        textColor: AppColors.contentColor,
      );
    }
  }
}
