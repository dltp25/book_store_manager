part of 'statistic_bloc.dart';

sealed class StatisticEvent extends Equatable {
  const StatisticEvent();

  @override
  List<Object> get props => [];
}

class LoadStatisticData extends StatisticEvent {
  final DateTime selectedMonth;

  const LoadStatisticData({required this.selectedMonth});
}
