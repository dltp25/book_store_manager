import 'package:bloc/bloc.dart';
import 'package:book_store_manager/models/home_statistic_model.dart';
import 'package:book_store_manager/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final OrderRepository _orderRepository;

  HomeBloc(this._orderRepository) : super(const HomeState()) {
    on<HomeLoading>(_onLoading);
  }

  _onLoading(HomeLoading event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    final HomeStatisticModel data =
        await _orderRepository.getMonthStatistic(DateTime.now());

    emit(state.copyWith(isLoading: false, homeStatistic: data));
  }
}
