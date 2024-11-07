import 'package:book_store_manager/utils/converter.dart';

class LoggingModel {
  final String id;
  final DateTime time;
  final String uid;
  final String function;
  final Map<String, String> metaData;

  LoggingModel({
    required this.id,
    required this.time,
    required this.uid,
    required this.function,
    required this.metaData,
  });

  factory LoggingModel.fromFirebase(String id, Map<String, dynamic> data) {
    Map<String, String> meta = {};
    if (data['metaData'] != null) {
      data['metaData'] as Map<String, dynamic>;
      for (var entry in data['metaData'].entries) {
        meta.addAll({entry.key: cvToString(entry.value)});
      }
    }
    return LoggingModel(
      id: id,
      time: cvToDate(data['time']),
      uid: cvToString(data['uid']),
      function: cvToString(data['function']),
      metaData: meta,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'uid': uid,
      'function': function,
      'metaData': metaData,
    };
  }
}
