import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store_manager/constant/data_document.dart';
import 'package:book_store_manager/models/order_model.dart';
import 'package:book_store_manager/repositories/order_repository.dart';
import 'package:book_store_manager/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/dialog_utils.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final UserRepository _userRepository;
  final OrderRepository _orderRepository;
  StreamSubscription? _userDetailsStream;

  UserDetailsBloc(
    this._userRepository,
    this._orderRepository,
  ) : super(const UserDetailsState()) {
    on<InitialEvent>(_onInitial);
    on<UserStreamUpdate>(_onUserUpdate);
    on<ConfirmOrderEvent>(_onConfirmOrder);
    on<PreparingConfirmOrderEvent>(_onPreparingConfirm);
    on<PreparedConfirmOrderEvent>(_onPreparedConfirm);
  }

  @override
  Future<void> close() async {
    super.close();
    _userDetailsStream?.cancel();
    _userDetailsStream = null;
  }

  _onInitial(InitialEvent event, Emitter emit) async {
    // Map<String, dynamic> userData =
    //     await _userRepository.getUserOrderStatistic(event.userId);

    // int totalOrders = userData['totalOrders'];
    // int completeOrders = userData['completeOrders'];

    // emit(state.copyWith(
    //   totalOrders: totalOrders,
    //   completeOrders: completeOrders,
    // ));

    _userDetailsStream = CombineLatestStream.list([
      _userRepository.userTransactionStream(event.userId),
      _orderRepository.userOrderStream(event.userId, [0, 1, 2, 3]),
    ]).listen((value) async {
      final userProfile = value[0];
      final userOrders = value[1];

      int totalOrders = 0;
      int completeOrders = 0;
      for (var doc in userProfile.docs) {
        if (doc.id == DataDocument.allOrders) {
          totalOrders = doc.data().length;
        }

        if (doc.id == DataDocument.completeOrders) {
          completeOrders = doc.data().length;
        }
      }

      List<OrderModel> orders = [];

      final test = await Future.wait(
        userOrders.docs.map(
          (e) => _orderRepository.getAllProductInOrder(
            List.from(e.data()['products']),
          ),
        ),
      );

      for (int i = 0; i < userOrders.docs.length; i++) {
        orders.add(
          OrderModel.fromJson(
            userOrders.docs[i].id,
            userOrders.docs[i].data(),
            test[i],
          ),
        );
      }

      // for (var ele in userOrders.docs) {
      //   List<OrderProductModel> products = [];

      //   List<Map<String, dynamic>> rawJson = List.from(ele.data()['products']);

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

      if (!isClosed) {
        add(UserStreamUpdate(
          totalOrders: totalOrders,
          completeOrders: completeOrders,
          orders: orders,
        ));
      }
    });
  }

  _onUserUpdate(UserStreamUpdate event, Emitter emit) {
    List<OrderModel> sorted = List.from(event.orders);
    sorted.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));

    emit(state.copyWith(
      totalOrders: event.totalOrders,
      completeOrders: event.completeOrders,
      orders: sorted,
      isLoading: false,
    ));
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

  _onPreparingConfirm(PreparingConfirmOrderEvent event, Emitter emit) async {
    DialogUtils.showLoading();
    await _orderRepository.preparingConfirmOrder(event.orderId);
    DialogUtils.hideLoading();
    Fluttertoast.showToast(
      msg: "Đơn hàng đã chuyển sang trạng thái chờ lấy",
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  _onPreparedConfirm(PreparedConfirmOrderEvent event, Emitter emit) async {
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
