part of 'user_order_history_bloc.dart';

sealed class UserOrderHistoryEvent extends Equatable {
  const UserOrderHistoryEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends UserOrderHistoryEvent {
  final String userId;

  const InitialEvent({required this.userId});
}

class UpdateViewTypeEvent extends UserOrderHistoryEvent {
  final OrderHistorySortType viewType;

  const UpdateViewTypeEvent({required this.viewType});
}
