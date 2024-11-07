part of 'prepared_order_bloc.dart';

class PreparedOrderState extends Equatable {
  final bool isLoading;
  final List<OrderModel> preparedOrders;

  const PreparedOrderState({
    this.isLoading = true,
    this.preparedOrders = const [],
  });

  @override
  List<Object> get props => [isLoading, preparedOrders];

  PreparedOrderState copyWith({
    bool? isLoading,
    List<OrderModel>? preparedOrders,
  }) {
    return PreparedOrderState(
      isLoading: isLoading ?? this.isLoading,
      preparedOrders: preparedOrders ?? this.preparedOrders,
    );
  }
}
