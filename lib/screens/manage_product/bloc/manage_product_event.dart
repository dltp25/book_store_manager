part of 'manage_product_bloc.dart';

sealed class ManageProductEvent extends Equatable {
  const ManageProductEvent();

  @override
  List<Object> get props => [];
}

class ManageProductLoading extends ManageProductEvent {}

class SearchProductEvent extends ManageProductEvent {
  final String query;

  const SearchProductEvent({required this.query});
}

class FilterProductEvent extends ManageProductEvent {
  final List<String> bookType;
  final bool? inStockDescending;

  const FilterProductEvent({
    required this.bookType,
    required this.inStockDescending,
  });
}
