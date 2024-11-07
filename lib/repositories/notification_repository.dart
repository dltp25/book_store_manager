import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant/enum.dart';
import '../models/reply_notification_model.dart';
import 'services/notification/abstract_notification_service.dart';
import 'services/notification/notification_service.dart';

class NotificationRepository {
  late AbstractNotificationService _notiService;

  NotificationRepository() {
    _notiService = NotificationService();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> notiStream(
      NotiViewType type, int limit) {
    return _notiService.notiStream(type, limit);
  }

  Future<void> updateIsReadNoti(String notiId, bool isRead) async {
    return _notiService.updateIsReadNoti(notiId, isRead);
  }

  Future<void> createConfirmOrderNoti(String userId, String orderId) async {
    return _notiService.createConfirmOrderNoti(userId, orderId);
  }

  Future<void> createPreparedOrderNoti(String userId, String orderId) async {
    return _notiService.createPreparedOrderNoti(userId, orderId);
  }

  Future<void> createDeliverOrderNoti(String userId, String orderId) async {
    return _notiService.createDeliverOrderNoti(userId, orderId);
  }

  Future<void> readAllNoti() async {
    return _notiService.readAllNoti();
  }

  Future<void> createReplyNoti(
      String userId, ReplyNotificationModel noti) async {
    return _notiService.createReplyNoti(userId, noti);
  }
}
