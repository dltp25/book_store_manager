part of 'preparing_order_bloc.dart';

class PreparingOrderState extends Equatable {
  final bool isLoading;
  final List<OrderModel> preparingOrders;

  const PreparingOrderState({
    this.isLoading = true,
    this.preparingOrders = const [],
  });

  @override
  List<Object> get props => [isLoading, preparingOrders];

  PreparingOrderState copyWith({
    bool? isLoading,
    List<OrderModel>? preparingOrders,
  }) {
    return PreparingOrderState(
      isLoading: isLoading ?? this.isLoading,
      preparingOrders: preparingOrders ?? this.preparingOrders,
    );
  }
}
