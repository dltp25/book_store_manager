import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constant/enum.dart';
import '../../../models/reply_notification_model.dart';

abstract class AbstractNotificationService {
  Stream<QuerySnapshot<Map<String, dynamic>>> notiStream(
      NotiViewType type, int limit);

  Future<void> updateIsReadNoti(String notiId, bool isRead);

  Future<void> createConfirmOrderNoti(String userId, String orderId);

  Future<void> createPreparedOrderNoti(String userId, String orderId);

  Future<void> createDeliverOrderNoti(String userId, String orderId);

  Future<void> readAllNoti();

  Future<void> createReplyNoti(String userId, ReplyNotificationModel noti);
}
