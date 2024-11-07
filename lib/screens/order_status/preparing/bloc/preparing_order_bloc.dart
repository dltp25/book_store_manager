import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store_manager/models/order_model.dart';
import 'package:book_store_manager/repositories/order_repository.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'preparing_order_event.dart';
part 'preparing_order_state.dart';

class PreparingOrderBloc
    extends Bloc<PreparingOrderEvent, PreparingOrderState> {
  final OrderRepository _orderRepository;
  StreamSubscription? _preparingStream;

  PreparingOrderBloc(this._orderRepository)
      : super(const PreparingOrderState()) {
    on<InitialEvent>(_onInitial);
    on<StreamUpdateEvent>(_onStreamUpdate);
    on<PreparingConfirmEvent>(_onPreparingConfirm);
  }

  @override
  Future<void> close() async {
    _preparingStream?.cancel();
    _preparingStream = null;
    super.close();
  }

  _onInitial(InitialEvent event, Emitter emit) {
    _preparingStream =
        _orderRepository.ordersStream(1).listen((streamEvent) async {
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
          add(StreamUpdateEvent(preparingOrders: orders));
        }
      } else {
        if (!isClosed) {
          add(const StreamUpdateEvent(preparingOrders: []));
        }
      }
    });
  }

  _onStreamUpdate(StreamUpdateEvent event, Emitter emit) {
    emit(state.copyWith(
      isLoading: false,
      preparingOrders: event.preparingOrders,
    ));
  }

  _onPreparingConfirm(PreparingConfirmEvent event, Emitter emit) async {
    DialogUtils.showLoading();
    await _orderRepository.preparingConfirmOrder(event.orderId);
    DialogUtils.hideLoading();
    Fluttertoast.showToast(
      msg: "Đơn hàng đã chuyển sang trạng thái chờ lấy",
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
}
