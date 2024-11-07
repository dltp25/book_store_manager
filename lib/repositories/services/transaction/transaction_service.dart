import 'package:book_store_manager/constant/data_collections.dart';
import 'package:book_store_manager/extensions/datetime_ex.dart';
import 'package:book_store_manager/models/home_statistic_model.dart';
import 'package:book_store_manager/utils/converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'abstract_transaction_service.dart';

class TransactionService extends AbstractTransactionService {
  @override
  Future<HomeStatisticModel> getMonthStatistic(DateTime date) async {
    final query = await FirebaseFirestore.instance
        .collection(DataCollection.orders)
        .where('dateCreated', isGreaterThanOrEqualTo: date.startOfMonth())
        .where('dateCreated', isLessThanOrEqualTo: date.endOfMonth())
        .get();

    int total = query.size;
    int complete = query.docs
        .where((element) => cvToInt(element.data()['status']) == 4)
        .length;
    double revenue = 0;
    for (var ele in query.docs) {
      if (cvToInt(ele.data()['status']) == 4) {
        revenue += cvToDouble(ele.data()['totalPrice']);
      }
    }

    return HomeStatisticModel(
      totalOrder: total,
      completeOrder: complete,
      revenue: revenue,
    );
  }
}
