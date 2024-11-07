part of 'order_done_bloc.dart';

class OrderDoneState extends Equatable {
  final bool isLoading;
  final DateTime? selectedMonth;
  final List<OrderModel> orders;
  final List<OrderModel> cancelOrders;
  final List<OrderModel> completeOrders;
  final List<OrderModel> showedOrders;
  final OrderHistorySortType viewType;
  final String searchQuery;

  const OrderDoneState({
    this.isLoading = true,
    this.selectedMonth,
    this.orders = const [],
    this.cancelOrders = const [],
    this.completeOrders = const [],
    this.showedOrders = const [],
    this.viewType = OrderHistorySortType.all,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props =>
      [isLoading, selectedMonth, orders, showedOrders, viewType, searchQuery];

  OrderDoneState copyWith({
    bool? isLoading,
    DateTime? selectedMonth,
    List<OrderModel>? orders,
    List<OrderModel>? cancelOrders,
    List<OrderModel>? completeOrders,
    List<OrderModel>? showedOrders,
    OrderHistorySortType? viewType,
    String? searchQuery,
  }) {
    return OrderDoneState(
      isLoading: isLoading ?? this.isLoading,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      orders: orders ?? this.orders,
      cancelOrders: cancelOrders ?? this.cancelOrders,
      completeOrders: completeOrders ?? this.completeOrders,
      showedOrders: showedOrders ?? this.showedOrders,
      viewType: viewType ?? this.viewType,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
