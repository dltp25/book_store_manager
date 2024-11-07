part of 'manage_order_bloc.dart';

class ManageOrderState extends Equatable {
  final bool isLoading;
  final ManageOrderSortType sortType;
  final List<OrderModel> orders;
  final List<OrderModel> expressOrders;
  final List<OrderModel> fastOrders;
  final List<OrderModel> basicOrders;

  const ManageOrderState({
    this.isLoading = true,
    this.sortType = ManageOrderSortType.newest,
    this.orders = const [],
    this.expressOrders = const [],
    this.fastOrders = const [],
    this.basicOrders = const [],
  });

  @override
  List<Object> get props => [isLoading, sortType, orders];

  ManageOrderState copyWith({
    bool? isLoading,
    ManageOrderSortType? sortType,
    List<OrderModel>? orders,
    List<OrderModel>? expressOrders,
    List<OrderModel>? fastOrders,
    List<OrderModel>? basicOrders,
  }) {
    return ManageOrderState(
      isLoading: isLoading ?? this.isLoading,
      sortType: sortType ?? this.sortType,
      orders: orders ?? this.orders,
      expressOrders: expressOrders ?? this.expressOrders,
      fastOrders: fastOrders ?? this.fastOrders,
      basicOrders: basicOrders ?? this.basicOrders,
    );
  }
}
