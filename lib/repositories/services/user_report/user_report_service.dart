import 'package:book_store_manager/constant/data_collections.dart';
import 'package:book_store_manager/models/user_report_model.dart';
import 'package:book_store_manager/utils/converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'abstract_user_report_service.dart';

class UserReportService extends AbstractUserReportService {
  final _ref = FirebaseFirestore.instance.collection(DataCollection.report);

  @override
  Future<List<UserReportModel>> getUserReport(int status) async {
    List<UserReportModel> res = [];
    final query = await _ref.where('status', isEqualTo: status).get();

    final futureGroup = await Future.wait(
      query.docs.map(
        (e) => getFeedbackInfor(cvToString(e.data()['feedbackId'])),
      ),
    );

    for (int i = 0; i < query.size; i++) {
      res.add(UserReportModel(
        id: query.docs[i].id,
        feedbackId: cvToString(query.docs[i].data()['feedbackId']),
        report: cvToString(query.docs[i].data()['report']),
        status: cvToInt(query.docs[i].data()['status']),
        date: cvToDate(query.docs[i].data()['date']),
        feedbackAvatar: futureGroup[i]['avatar'],
        feedbackIsHide: futureGroup[i]['isHide'],
        feedbackReview: futureGroup[i]['review'],
        feedbackUserName: futureGroup[i]['name'],
        feedbackRating: futureGroup[i]['rating'],
      ));
    }

    return res;
  }

  @override
  Future<Map<String, dynamic>> getFeedbackInfor(String feedbackId) async {
    final query = await FirebaseFirestore.instance
        .collection(DataCollection.feedback)
        .doc(feedbackId)
        .get();
    String name = cvToString(query.data()?['user']);
    String avatar = cvToString(query.data()?['userImg']);
    String review = cvToString(query.data()?['review']);
    bool isHide = cvToBool(query.data()?['isHide']);
    int rating = cvToInt(query.data()?['rating']);

    return {
      'name': name,
      'avatar': avatar,
      'review': review,
      'isHide': isHide,
      'rating': rating,
    };
  }

  @override
  Future<void> readReport(String reportId) async {
    final query = _ref.doc(reportId);

    await query.set({'status': -1}, SetOptions(merge: true));
  }

  @override
  Future<void> hideFeedback(String feedbackId) async {
    final ref = FirebaseFirestore.instance
        .collection(DataCollection.feedback)
        .doc(feedbackId);

    final futureGroup = await Future.wait([
      ref.set({'isHide': true}, SetOptions(merge: true)),
      _ref
          .where('feedbackId', isEqualTo: feedbackId)
          .where('status', isEqualTo: 0)
          .get(),
    ]);
    QuerySnapshot<Map<String, dynamic>> temp =
        futureGroup[1] as QuerySnapshot<Map<String, dynamic>>;

    await Future.wait(temp.docs.map(
      (e) => e.reference.set({'status': -1}, SetOptions(merge: true)),
    ));
  }
}
