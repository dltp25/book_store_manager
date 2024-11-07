import '../../../models/home_statistic_model.dart';

abstract class AbstractTransactionService {
  Future<HomeStatisticModel> getMonthStatistic(DateTime date);
}
