part of 'manage_order_bloc.dart';

sealed class ManageOrderEvent extends Equatable {
  const ManageOrderEvent();

  @override
  List<Object> get props => [];
}

class LoadingEvent extends ManageOrderEvent {}

class StreamUpdateEvent extends ManageOrderEvent {
  final List<OrderModel> orders;

  const StreamUpdateEvent({required this.orders});
}

class UpdateSortTypeEvent extends ManageOrderEvent {
  final ManageOrderSortType sortType;

  const UpdateSortTypeEvent({required this.sortType});
}

class ConfirmOrderEvent extends ManageOrderEvent {
  final String orderId;

  const ConfirmOrderEvent({required this.orderId});
}
