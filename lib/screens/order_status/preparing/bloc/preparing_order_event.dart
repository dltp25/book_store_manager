part of 'preparing_order_bloc.dart';

sealed class PreparingOrderEvent extends Equatable {
  const PreparingOrderEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends PreparingOrderEvent {}

class StreamUpdateEvent extends PreparingOrderEvent {
  final List<OrderModel> preparingOrders;

  const StreamUpdateEvent({required this.preparingOrders});
}

class PreparingConfirmEvent extends PreparingOrderEvent {
  final String orderId;

  const PreparingConfirmEvent({required this.orderId});
}
