import 'package:bloc/bloc.dart';
import 'package:book_store_manager/constant/enum.dart';
import 'package:book_store_manager/extensions/datetime_ex.dart';
import 'package:book_store_manager/models/order_model.dart';
import 'package:book_store_manager/repositories/order_repository.dart';
import 'package:diacritic/diacritic.dart';
import 'package:equatable/equatable.dart';

part 'order_done_event.dart';
part 'order_done_state.dart';

class OrderDoneBloc extends Bloc<OrderDoneEvent, OrderDoneState> {
  final OrderRepository _orderRepository;

  OrderDoneBloc(this._orderRepository) : super(const OrderDoneState()) {
    on<InitialEvent>(_onInitial);
    on<UpdateSelectedMonthEvent>(_onUpdateSelectedMonth);
    on<UpdateViewTypeEvent>(_onUpdateViewType);
    on<SearchingOrderEvent>(_onSearching);
  }

  _onInitial(InitialEvent event, Emitter emit) async {
    DateTime current = DateTime.now().getMonthAndYear();

    List<OrderModel> doneOrders =
        await _orderRepository.getDoneOrdersOfMonth(current);

    doneOrders.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
    List<OrderModel> showedOrders = List.from(doneOrders);
    List<OrderModel> completedOrders = [];
    List<OrderModel> cancelledOrders = [];

    for (var ele in doneOrders) {
      if (ele.status == 4) {
        completedOrders.add(ele);
      } else {
        cancelledOrders.add(ele);
      }
    }

    emit(state.copyWith(
      isLoading: false,
      cancelOrders: cancelledOrders,
      completeOrders: completedOrders,
      orders: doneOrders,
      showedOrders: showedOrders,
      selectedMonth: current,
      viewType: OrderHistorySortType.all,
    ));
  }

  _onUpdateSelectedMonth(UpdateSelectedMonthEvent event, Emitter emit) async {
    DateTime newTime = event.selectedMonth.getMonthAndYear();

    if (newTime != state.selectedMonth) {
      emit(state.copyWith(selectedMonth: newTime, isLoading: true));

      List<OrderModel> doneOrders =
          await _orderRepository.getDoneOrdersOfMonth(newTime);
      List<OrderModel> showedOrders = List.from(doneOrders);
      List<OrderModel> completedOrders = [];
      List<OrderModel> cancelledOrders = [];

      for (var ele in doneOrders) {
        if (ele.status == 4) {
          completedOrders.add(ele);
        } else {
          cancelledOrders.add(ele);
        }
      }

      emit(state.copyWith(
        isLoading: false,
        cancelOrders: cancelledOrders,
        completeOrders: completedOrders,
        orders: doneOrders,
        showedOrders: showedOrders,
        viewType: OrderHistorySortType.all,
        searchQuery: '',
      ));
    }
  }

  _onUpdateViewType(UpdateViewTypeEvent event, Emitter emit) {
    if (event.viewType != state.viewType) {
      emit(state.copyWith(viewType: event.viewType));

      List<OrderModel> newShowedOrders = [];

      switch (event.viewType) {
        case OrderHistorySortType.all:
          newShowedOrders = List.from(state.orders);
          break;
        case OrderHistorySortType.complete:
          newShowedOrders = List.from(state.completeOrders);
          break;
        case OrderHistorySortType.cancel:
          newShowedOrders = List.from(state.cancelOrders);
          break;
      }

      if (state.searchQuery.isNotEmpty) {
        for (var ele in newShowedOrders) {
          String userName = removeDiacritics(ele.userName.toLowerCase());
          String userPhone = ele.phone;

          if (!userName.contains(state.searchQuery) &&
              !userPhone.contains(state.searchQuery)) {
            newShowedOrders.remove(ele);
          }
        }
      }

      emit(state.copyWith(showedOrders: newShowedOrders));
    }
  }

  _onSearching(SearchingOrderEvent event, Emitter emit) {
    emit(state.copyWith(searchQuery: event.query));

    List<OrderModel> showedOrders = [];
    switch (state.viewType) {
      case OrderHistorySortType.all:
        showedOrders = List.from(state.orders);
        break;
      case OrderHistorySortType.complete:
        showedOrders = List.from(state.completeOrders);
        break;
      case OrderHistorySortType.cancel:
        showedOrders = List.from(state.cancelOrders);
        break;
    }

    for (var ele in showedOrders) {
      String userName = removeDiacritics(ele.userName.toLowerCase());
      String userPhone = ele.phone;

      if (!userName.contains(state.searchQuery) &&
          !userPhone.contains(state.searchQuery)) {
        showedOrders.remove(ele);
      }
    }

    emit(state.copyWith(showedOrders: showedOrders));
  }
}
