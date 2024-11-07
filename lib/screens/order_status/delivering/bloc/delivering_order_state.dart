part of 'delivering_order_bloc.dart';

class DeliveringOrderState extends Equatable {
  final bool isLoading;
  final List<OrderModel> deliveringOrders;

  const DeliveringOrderState({
    this.isLoading = true,
    this.deliveringOrders = const [],
  });

  @override
  List<Object> get props => [isLoading, deliveringOrders];

  DeliveringOrderState copyWith({
    bool? isLoading,
    List<OrderModel>? deliveringOrders,
  }) {
    return DeliveringOrderState(
      isLoading: isLoading ?? this.isLoading,
      deliveringOrders: deliveringOrders ?? this.deliveringOrders,
    );
  }
}
