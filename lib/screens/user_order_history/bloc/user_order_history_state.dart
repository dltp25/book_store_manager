part of 'user_order_history_bloc.dart';

class UserOrderHistoryState extends Equatable {
  final bool isLoading;
  final int totalOrder;
  final int completeOrder;
  final int cancelOrder;

  final Map<int, int> chartData;

  final OrderHistorySortType viewType;
  final List<OrderModel> orders;
  final List<OrderModel> showedOrders;

  const UserOrderHistoryState({
    this.isLoading = true,
    this.totalOrder = 0,
    this.completeOrder = 0,
    this.cancelOrder = 0,
    this.chartData = const {},
    this.viewType = OrderHistorySortType.all,
    this.orders = const [],
    this.showedOrders = const [],
  });

  @override
  List<Object> get props => [
        isLoading,
        totalOrder,
        completeOrder,
        cancelOrder,
        chartData,
        viewType,
        orders,
        showedOrders,
      ];

  UserOrderHistoryState copyWith({
    bool? isLoading,
    int? totalOrder,
    int? completeOrder,
    int? cancelOrder,
    Map<int, int>? chartData,
    OrderHistorySortType? viewType,
    List<OrderModel>? orders,
    List<OrderModel>? showedOrders,
  }) {
    return UserOrderHistoryState(
      isLoading: isLoading ?? this.isLoading,
      totalOrder: totalOrder ?? this.totalOrder,
      completeOrder: completeOrder ?? this.completeOrder,
      cancelOrder: cancelOrder ?? this.cancelOrder,
      chartData: chartData ?? this.chartData,
      viewType: viewType ?? this.viewType,
      orders: orders ?? this.orders,
      showedOrders: showedOrders ?? this.showedOrders,
    );
  }
}
