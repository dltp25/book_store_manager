part of 'user_details_bloc.dart';

class UserDetailsState extends Equatable {
  final bool isLoading;
  final int totalOrders;
  final int completeOrders;
  final List<OrderModel> orders;

  const UserDetailsState({
    this.isLoading = true,
    this.totalOrders = 0,
    this.completeOrders = 0,
    this.orders = const [],
  });

  @override
  List<Object> get props => [isLoading, totalOrders, completeOrders, orders];

  UserDetailsState copyWith({
    bool? isLoading,
    int? totalOrders,
    int? completeOrders,
    List<OrderModel>? orders,
  }) {
    return UserDetailsState(
      isLoading: isLoading ?? this.isLoading,
      totalOrders: totalOrders ?? this.totalOrders,
      completeOrders: completeOrders ?? this.completeOrders,
      orders: orders ?? this.orders,
    );
  }
}
