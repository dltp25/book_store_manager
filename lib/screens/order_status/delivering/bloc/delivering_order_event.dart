part of 'delivering_order_bloc.dart';

sealed class DeliveringOrderEvent extends Equatable {
  const DeliveringOrderEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends DeliveringOrderEvent {}

class StreamUpdateEvent extends DeliveringOrderEvent {
  final List<OrderModel> deliveringOrders;

  const StreamUpdateEvent({required this.deliveringOrders});
}
