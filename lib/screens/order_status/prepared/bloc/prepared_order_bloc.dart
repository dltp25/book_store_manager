import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store_manager/models/order_model.dart';
import 'package:book_store_manager/repositories/order_repository.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'prepared_order_event.dart';
part 'prepared_order_state.dart';

class PreparedOrderBloc extends Bloc<PreparedOrderEvent, PreparedOrderState> {
  final OrderRepository _orderRepository;
  StreamSubscription? _preparedStream;

  PreparedOrderBloc(this._orderRepository) : super(const PreparedOrderState()) {
    on<InitialEvent>(_onInitial);
    on<StreamUpdateEvent>(_onStreamUpdate);
    on<PreparedConfirmEvent>(_onPreparedConfirm);
  }

  @override
  Future<void> close() async {
    _preparedStream?.cancel();
    _preparedStream = null;
    super.close();
  }

  _onInitial(InitialEvent event, Emitter emit) {
    _preparedStream =
        _orderRepository.ordersStream(2).listen((streamEvent) async {
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
          add(StreamUpdateEvent(preparedOrders: orders));
        }
      } else {
        if (!isClosed) {
          add(const StreamUpdateEvent(preparedOrders: []));
        }
      }
    });
  }

  _onStreamUpdate(StreamUpdateEvent event, Emitter emit) {
    emit(state.copyWith(
      isLoading: false,
      preparedOrders: event.preparedOrders,
    ));
  }

  _onPreparedConfirm(PreparedConfirmEvent event, Emitter emit) async {
    DialogUtils.showLoading();
    await _orderRepository.preparedConfirmOrder(event.orderId);
    DialogUtils.hideLoading();
    Fluttertoast.showToast(
      msg: "Đơn hàng đang được vận chuyển",
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
}
