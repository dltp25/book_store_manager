import 'package:bloc/bloc.dart';
import 'package:book_store_manager/models/order_model.dart';
import 'package:book_store_manager/repositories/order_repository.dart';
import 'package:book_store_manager/repositories/user_repository.dart';
import '../../../constant/enum.dart';
import 'package:equatable/equatable.dart';

part 'user_order_history_event.dart';
part 'user_order_history_state.dart';

class UserOrderHistoryBloc
    extends Bloc<UserOrderHistoryEvent, UserOrderHistoryState> {
  final UserRepository _userRepository;
  final OrderRepository _orderRepository;

  UserOrderHistoryBloc(this._userRepository, this._orderRepository)
      : super(const UserOrderHistoryState()) {
    on<InitialEvent>(_onInitial);
    on<UpdateViewTypeEvent>(_onUpdateViewType);
  }

  _onInitial(InitialEvent event, Emitter emit) async {
    final futureGroup = await Future.wait([
      _userRepository.getUserTotalOrder(event.userId),
      _userRepository.getUserCompleteOrder(event.userId),
      _userRepository.getUserCancelOrder(event.userId),
      _orderRepository.getUserDoneOrders(event.userId),
    ]);

    int total = futureGroup[0] as int;
    int complete = futureGroup[1] as int;
    int cancel = futureGroup[2] as int;
    List<OrderModel> orders = futureGroup[3] as List<OrderModel>;

    int currentYear = DateTime.now().year;
    Map<int, int> chartData = {};

    for (var order in orders) {
      if (order.dateCreated.year == currentYear) {
        int month = order.dateCreated.month;

        if (chartData.containsKey(month)) {
          chartData[month] = chartData[month]! + 1;
        } else {
          chartData[month] = 1;
        }
      }
    }

    emit(state.copyWith(
      isLoading: false,
      totalOrder: total,
      completeOrder: complete,
      cancelOrder: cancel,
      orders: orders,
      showedOrders: orders,
      chartData: chartData,
    ));
  }

  _onUpdateViewType(UpdateViewTypeEvent event, Emitter emit) {
    if (event.viewType != state.viewType) {
      emit(state.copyWith(viewType: event.viewType));

      List<OrderModel> newShowedOrder = [];
      switch (event.viewType) {
        case OrderHistorySortType.all:
          newShowedOrder = List.from(state.orders);
          break;
        case OrderHistorySortType.complete:
          newShowedOrder = List.from(
            state.orders.where((element) => element.status == 4),
          );
          break;
        case OrderHistorySortType.cancel:
          newShowedOrder = List.from(
            state.orders.where((element) => element.status != 4),
          );
          break;
      }

      emit(state.copyWith(showedOrders: newShowedOrder));
    }
  }
}
