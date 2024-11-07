import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store_manager/models/order_model.dart';
import 'package:book_store_manager/repositories/order_repository.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constant/enum.dart';

part 'manage_order_event.dart';
part 'manage_order_state.dart';

class ManageOrderBloc extends Bloc<ManageOrderEvent, ManageOrderState> {
  final OrderRepository _orderRepository;
  StreamSubscription? _orderStream;

  ManageOrderBloc(this._orderRepository) : super(const ManageOrderState()) {
    on<LoadingEvent>(_onLoading);
    on<StreamUpdateEvent>(_onStreamUpdate);
    on<UpdateSortTypeEvent>(_onUpdateSortType);
    on<ConfirmOrderEvent>(_onConfirmOrder);
  }

  @override
  Future<void> close() async {
    _orderStream?.cancel();
    _orderStream = null;
    super.close();
  }

  _onLoading(LoadingEvent event, Emitter emit) {
    _orderStream = _orderRepository.ordersStream(0).listen((streamEvent) async {
      if (streamEvent.docs.isNotEmpty) {
        List<OrderModel> orders = [];

        final test = await Future.wait(
          streamEvent.docs.map(
            (e) => _orderRepository.getAllProductInOrder(
              List.from(e.data()['products']),
            ),
          ),
        );

        for (int i = 0; i < streamEvent.docs.length; i++) {
          orders.add(
            OrderModel.fromJson(
              streamEvent.docs[i].id,
              streamEvent.docs[i].data(),
              test[i],
            ),
          );
        }

        // for (var ele in streamEvent.docs) {
        //   List<OrderProductModel> products = [];

        //   List<Map<String, dynamic>> rawJson =
        //       List.from(ele.data()['products']);

        //   final productsInfo = await Future.wait(
        //     rawJson.map(
        //       (e) => _orderRepository.getProductInOrder(e['productID']),
        //     ),
        //   );

        //   for (int i = 0; i < rawJson.length; i++) {
        //     OrderProductModel temp = OrderProductModel.fromJson(
        //       rawJson[i],
        //       productsInfo[i]['productName'],
        //       productsInfo[i]['imgURL'],
        //     );
        //     products.add(temp);
        //   }

        //   orders.add(OrderModel.fromJson(ele.id, ele.data(), products));
        // }

        orders.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));

        if (!isClosed) {
          add(StreamUpdateEvent(orders: orders));
        }
      } else {
        if (!isClosed) {
          add(const StreamUpdateEvent(orders: []));
        }
      }
    });
  }

  _onStreamUpdate(StreamUpdateEvent event, Emitter emit) {
    List<OrderModel> express = [];
    List<OrderModel> fast = [];
    List<OrderModel> basic = [];
    for (var ele in event.orders) {
      if (ele.transportCode == 1) {
        basic.add(ele);
      } else if (ele.transportCode == 2) {
        fast.add(ele);
      } else {
        express.add(ele);
      }
    }

    emit(state.copyWith(
      orders: event.orders,
      basicOrders: basic,
      fastOrders: fast,
      expressOrders: express,
      isLoading: false,
    ));
  }

  _onUpdateSortType(UpdateSortTypeEvent event, Emitter emit) {
    if (event.sortType != state.sortType) {
      List<OrderModel> orders = List.from(state.orders);

      if (event.sortType == ManageOrderSortType.newest) {
        orders.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
      } else {
        orders.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
      }

      List<OrderModel> express = [];
      List<OrderModel> fast = [];
      List<OrderModel> basic = [];
      for (var ele in orders) {
        if (ele.transportCode == 1) {
          basic.add(ele);
        } else if (ele.transportCode == 2) {
          fast.add(ele);
        } else {
          express.add(ele);
        }
      }

      emit(state.copyWith(
        basicOrders: basic,
        fastOrders: fast,
        expressOrders: express,
        sortType: event.sortType,
        orders: orders,
      ));
    }
  }

  _onConfirmOrder(ConfirmOrderEvent event, Emitter emit) async {
    DialogUtils.showLoading();
    await _orderRepository.confirmOrder(event.orderId);
    DialogUtils.hideLoading();
    Fluttertoast.showToast(
      msg: "Xác nhận đơn hàng thành công",
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
}
