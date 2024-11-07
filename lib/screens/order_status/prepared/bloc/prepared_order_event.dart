part of 'prepared_order_bloc.dart';

sealed class PreparedOrderEvent extends Equatable {
  const PreparedOrderEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends PreparedOrderEvent {}

class StreamUpdateEvent extends PreparedOrderEvent {
  final List<OrderModel> preparedOrders;

  const StreamUpdateEvent({required this.preparedOrders});
}

class PreparedConfirmEvent extends PreparedOrderEvent {
  final String orderId;

  const PreparedConfirmEvent({required this.orderId});
}
