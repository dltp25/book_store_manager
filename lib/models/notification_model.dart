import 'package:book_store_manager/utils/converter.dart';

class NotificationModel {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String type;
  final DateTime date;
  final bool isRead;
  final int status;
  final String orderId;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.type,
    required this.date,
    required this.isRead,
    required this.status,
    required this.orderId,
  });

  factory NotificationModel.fromJson(String id, String userName,
      String userAvatar, Map<String, dynamic> json) {
    return NotificationModel(
      id: id,
      userId: cvToString(json['userId']),
      userName: userName,
      userAvatar: userAvatar,
      type: cvToString(json['type']),
      date: cvToDate(json['date']),
      isRead: cvToBool(json['isRead']),
      orderId: cvToString(json['orderId']),
      status: cvToInt(json['status']),
    );
  }
}
