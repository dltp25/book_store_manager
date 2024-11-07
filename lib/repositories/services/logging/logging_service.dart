import 'package:book_store_manager/constant/data_collections.dart';
import 'package:book_store_manager/extensions/datetime_ex.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/logging_model.dart';

class LoggingService {
  Query<LoggingModel> loggingQuery(DateTime selectedDate) {
    return FirebaseFirestore.instance
        .collection(DataCollection.logging)
        .where('time', isGreaterThanOrEqualTo: selectedDate.toStartOfDate())
        .where('time', isLessThanOrEqualTo: selectedDate.toEndOfDate())
        .orderBy('time', descending: true)
        .withConverter(
      fromFirestore: (snapshot, options) {
        return LoggingModel.fromFirebase(snapshot.id, snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }
}
