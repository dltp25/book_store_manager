part of 'order_done_bloc.dart';

sealed class OrderDoneEvent extends Equatable {
  const OrderDoneEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends OrderDoneEvent {}

class UpdateSelectedMonthEvent extends OrderDoneEvent {
  final DateTime selectedMonth;

  const UpdateSelectedMonthEvent({required this.selectedMonth});
}

class UpdateViewTypeEvent extends OrderDoneEvent {
  final OrderHistorySortType viewType;

  const UpdateViewTypeEvent({required this.viewType});
}

class SearchingOrderEvent extends OrderDoneEvent {
  final String query;

  const SearchingOrderEvent({required this.query});
}
