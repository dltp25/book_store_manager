import 'package:book_store_manager/constant/data_collections.dart';
import 'package:book_store_manager/constant/enum.dart';
import 'package:book_store_manager/extensions/datetime_ex.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/feedback_model.dart';
import '../../../models/user_model.dart';
import 'abstract_feedback_service.dart';

class FeedbackService extends AbstractFeedbackService {
  final _ref = FirebaseFirestore.instance.collection(DataCollection.feedback);

  @override
  Future<List<FeedbackModel>> getFeedback(
      ManageFeedbackType type, DateTime month) async {
    List<FeedbackModel> res = [];
    final bool isRead = (type == ManageFeedbackType.read);

    final query = await _ref
        .where('isHide', isEqualTo: false)
        .where('isRead', isEqualTo: isRead)
        .where('dateSubmit', isGreaterThanOrEqualTo: month.startOfMonth())
        .where('dateSubmit', isLessThanOrEqualTo: month.endOfMonth())
        .get();

    final futureGroups = await Future.wait(query.docs.map(
      (e) => getUserLiteModel(e.data()['userId']),
    ));

    for (int i = 0; i < query.size; i++) {
      var docData = query.docs[i];
      res.add(
        FeedbackModel.fromJson(
          docData.id,
          query.docs[i].data(),
          futureGroups[i].name,
          futureGroups[i].avatar,
        ),
      );
    }

    return res;
  }

  @override
  Future<UserLiteModel> getUserLiteModel(String userId) async {
    final query = await FirebaseFirestore.instance
        .collection(DataCollection.user)
        .doc(userId)
        .get();

    return UserLiteModel.fromJson(query.id, query.data()!);
  }

  @override
  Future<void> likeFeedback(String feedbackId, bool like) async {
    final doc = _ref.doc(feedbackId);
    await doc.set({'isLiked': like}, SetOptions(merge: true));
  }

  @override
  Future<void> readFeedback(String feedbackId, bool read) async {
    final doc = _ref.doc(feedbackId);
    await doc.set({'isRead': read}, SetOptions(merge: true));
  }

  @override
  Future<void> hideFeedback(String feedbackId, bool hide) async {
    final doc = _ref.doc(feedbackId);
    await doc.set({'isHide': hide, 'isRead': true}, SetOptions(merge: true));
  }

  @override
  Future<void> unHideFeedback(String feedbackId) async {
    final doc = _ref.doc(feedbackId);
    await doc.set({'isHide': false}, SetOptions(merge: true));
  }

  @override
  Future<void> replyFeedback(String feedbackId, String reply) async {
    final doc = _ref.doc(feedbackId);
    await doc.set({
      'isReply': true,
      'adminReply': reply,
    }, SetOptions(merge: true));
  }

  @override
  Future<List<FeedbackModel>> getHideFeedback() async {
    List<FeedbackModel> feedbacks = [];
    final query = await _ref.where('isHide', isEqualTo: true).get();

    final futureGroups = await Future.wait(query.docs.map(
      (e) => getUserLiteModel(e.data()['userId']),
    ));

    for (int i = 0; i < query.size; i++) {
      var docData = query.docs[i];
      feedbacks.add(
        FeedbackModel.fromJson(
          docData.id,
          query.docs[i].data(),
          futureGroups[i].name,
          futureGroups[i].avatar,
        ),
      );
    }

    return feedbacks;
  }

  @override
  Future<List<FeedbackModel>> getFeedbackOfProduct(String productId) async {
    List<FeedbackModel> res = [];
    final query = await _ref
        .where('isHide', isEqualTo: false)
        .where('bookID', isEqualTo: productId)
        .get();

    final futureGroups = await Future.wait(query.docs.map(
      (e) => getUserLiteModel(e.data()['userId']),
    ));

    for (int i = 0; i < query.size; i++) {
      var docData = query.docs[i];
      res.add(
        FeedbackModel.fromJson(
          docData.id,
          query.docs[i].data(),
          futureGroups[i].name,
          futureGroups[i].avatar,
        ),
      );
    }

    return res;
  }
}
