part of 'create_import_product_bloc.dart';

sealed class CreateImportProductEvent extends Equatable {
  const CreateImportProductEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends CreateImportProductEvent {}

class AddProductEvent extends CreateImportProductEvent {
  final ProductLiteModel product;

  const AddProductEvent({required this.product});
}

class RemoveProductEvent extends CreateImportProductEvent {
  final ProductLiteModel product;

  const RemoveProductEvent({required this.product});
}

class UpdateProductQuantityEvent extends CreateImportProductEvent {
  final ProductLiteModel product;
  final int quantity;

  const UpdateProductQuantityEvent({
    required this.product,
    required this.quantity,
  });
}

class ConfirmImportEvent extends CreateImportProductEvent {}
