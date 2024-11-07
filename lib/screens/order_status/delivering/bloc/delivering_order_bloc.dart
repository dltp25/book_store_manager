import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store_manager/models/order_model.dart';
import 'package:book_store_manager/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';

part 'delivering_order_event.dart';
part 'delivering_order_state.dart';

class DeliveringOrderBloc
    extends Bloc<DeliveringOrderEvent, DeliveringOrderState> {
  final OrderRepository _orderRepository;
  StreamSubscription? _deliveringStream;

  DeliveringOrderBloc(this._orderRepository)
      : super(const DeliveringOrderState()) {
    on<InitialEvent>(_onInitial);
    on<StreamUpdateEvent>(_onStreamUpdate);
  }

  @override
  Future<void> close() async {
    _deliveringStream?.cancel();
    _deliveringStream = null;
    super.close();
  }

  _onInitial(InitialEvent event, Emitter emit) {
    _deliveringStream =
        _orderRepository.ordersStream(3).listen((streamEvent) async {
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
          add(StreamUpdateEvent(deliveringOrders: orders));
        }
      } else {
        if (!isClosed) {
          add(const StreamUpdateEvent(deliveringOrders: []));
        }
      }
    });
  }

  _onStreamUpdate(StreamUpdateEvent event, Emitter emit) {
    emit(state.copyWith(
      isLoading: false,
      deliveringOrders: event.deliveringOrders,
    ));
  }
}
