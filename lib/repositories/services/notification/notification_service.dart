import 'package:book_store_manager/constant/data_collections.dart';
import 'package:book_store_manager/constant/enum.dart';
import 'package:book_store_manager/models/reply_notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'abstract_notification_service.dart';

class NotificationService extends AbstractNotificationService {
  final _notiRef =
      FirebaseFirestore.instance.collection(DataCollection.adminNoti);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> notiStream(
      NotiViewType type, int limit) {
    if (type == NotiViewType.all) {
      return _notiRef
          .orderBy('date', descending: true)
          .limit(limit)
          .snapshots();
    }

    return _notiRef
        .where('isRead', isEqualTo: false)
        .orderBy('date', descending: true)
        .limit(limit)
        .snapshots();
  }

  @override
  Future<void> updateIsReadNoti(String notiId, bool isRead) async {
    final docRef = _notiRef.doc(notiId);
    await docRef.set({
      'isRead': isRead,
    }, SetOptions(merge: true));
  }

  @override
  Future<void> createConfirmOrderNoti(String userId, String orderId) async {
    await FirebaseFirestore.instance
        .collection(DataCollection.user)
        .doc(userId)
        .collection(DataCollection.userNoti)
        .add({
      'title': 'Đơn hàng của bạn đã được xác nhận',
      'content':
          'Đơn hàng $orderId của bạn đã được người bán xác nhận. Cảm ơn bạn đã mua sắm cùng IBOO!',
      'date': DateTime.now(),
      'isRead': false,
      'actionCode': 'order_1',
    });
  }

  @override
  Future<void> createPreparedOrderNoti(String userId, String orderId) async {
    await FirebaseFirestore.instance
        .collection(DataCollection.user)
        .doc(userId)
        .collection(DataCollection.userNoti)
        .add({
      'title': 'Đơn hàng của bạn đã được chuẩn bị',
      'content':
          'Đơn hàng $orderId của bạn đã được người bán chuẩn bị xong. Đơn hàng sẽ sớm được giao cho người vận chuyển!',
      'date': DateTime.now(),
      'isRead': false,
      'actionCode': 'order_1',
    });
  }

  @override
  Future<void> createDeliverOrderNoti(String userId, String orderId) async {
    await FirebaseFirestore.instance
        .collection(DataCollection.user)
        .doc(userId)
        .collection(DataCollection.userNoti)
        .add({
      'title': 'Đơn hàng của bạn đã được giao cho người bán',
      'content':
          'Đơn hàng $orderId của bạn đã được giao cho bên vận chuyển. Đơn hàng sẽ sớm được giao đến bạn!',
      'date': DateTime.now(),
      'isRead': false,
      'actionCode': 'order_2',
    });
  }

  @override
  Future<void> readAllNoti() async {
    final allNotis = await _notiRef.where('isRead', isEqualTo: false).get();

    var batch = FirebaseFirestore.instance.batch();
    for (var ele in allNotis.docs) {
      batch.update(ele.reference, {'isRead': true});
    }

    await batch.commit();
  }

  @override
  Future<void> createReplyNoti(
      String userId, ReplyNotificationModel noti) async {
    final colRef = FirebaseFirestore.instance
        .collection(DataCollection.user)
        .doc(userId)
        .collection(DataCollection.userNoti);
    await colRef.add(noti.toJson());
  }
}
