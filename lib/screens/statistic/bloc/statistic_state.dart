part of 'statistic_bloc.dart';

class StatisticState extends Equatable {
  final bool isLoading;
  final DateTime? selectedMonth;
  final List<OrderModel> orders;
  final List<OrderModel> completeOrders;

  const StatisticState({
    this.isLoading = true,
    this.selectedMonth,
    this.orders = const [],
    this.completeOrders = const [],
  });

  @override
  List<Object?> get props => [isLoading, selectedMonth, orders, completeOrders];

  StatisticState copyWith({
    bool? isLoading,
    DateTime? selectedMonth,
    List<OrderModel>? orders,
    List<OrderModel>? completeOrders,
  }) {
    return StatisticState(
      isLoading: isLoading ?? this.isLoading,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      orders: orders ?? this.orders,
      completeOrders: completeOrders ?? this.completeOrders,
    );
  }
}
