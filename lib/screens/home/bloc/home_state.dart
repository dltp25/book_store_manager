part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final HomeStatisticModel? homeStatistic;

  const HomeState({
    this.isLoading = true,
    this.homeStatistic,
  });

  @override
  List<Object?> get props => [isLoading, homeStatistic];

  HomeState copyWith({
    bool? isLoading,
    HomeStatisticModel? homeStatistic,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      homeStatistic: homeStatistic ?? this.homeStatistic,
    );
  }
}
