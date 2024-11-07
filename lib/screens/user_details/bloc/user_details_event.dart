part of 'user_details_bloc.dart';

sealed class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends UserDetailsEvent {
  final String userId;

  const InitialEvent({required this.userId});
}

class UserStreamUpdate extends UserDetailsEvent {
  final int totalOrders;
  final int completeOrders;
  final List<OrderModel> orders;

  const UserStreamUpdate({
    required this.totalOrders,
    required this.completeOrders,
    required this.orders,
  });
}

class ConfirmOrderEvent extends UserDetailsEvent {
  final String orderId;

  const ConfirmOrderEvent({required this.orderId});
}

class PreparingConfirmOrderEvent extends UserDetailsEvent {
  final String orderId;

  const PreparingConfirmOrderEvent({required this.orderId});
}

class PreparedConfirmOrderEvent extends UserDetailsEvent {
  final String orderId;

  const PreparedConfirmOrderEvent({required this.orderId});
}
