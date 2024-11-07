part of 'order_details_bloc.dart';

class OrderDetailsState extends Equatable {
  final OrderModel? orderData;
  final bool isLoading;
  final int status;

  const OrderDetailsState({
    this.status = 0,
    this.orderData,
    this.isLoading = true,
  });

  @override
  List<Object?> get props => [orderData, isLoading, status];

  OrderDetailsState copyWith({
    int? status,
    bool? isLoading,
    OrderModel? orderData,
  }) {
    return OrderDetailsState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      orderData: orderData ?? this.orderData,
    );
  }
}
