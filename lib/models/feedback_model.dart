import 'package:book_store_manager/utils/converter.dart';

class FeedbackModel {
  final String id;
  final String userId;
  final String bookId;
  final String review;
  final int rating;
  final bool isRead;
  final bool isLiked;
  final bool isHide;
  final bool isReply;
  final String adminReply;
  final DateTime dateSubmit;
  final String userName;
  final String userAvatar;

  FeedbackModel({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.review,
    required this.rating,
    required this.isRead,
    required this.isLiked,
    required this.isHide,
    required this.isReply,
    required this.adminReply,
    required this.dateSubmit,
    required this.userName,
    required this.userAvatar,
  });

  factory FeedbackModel.fromJson(String id, Map<String, dynamic> json,
      String userName, String userAvatar) {
    return FeedbackModel(
      id: id,
      userId: cvToString(json['userId']),
      bookId: cvToString(json['bookID']),
      review: cvToString(json['review']),
      rating: cvToInt(json['rating']),
      isRead: cvToBool(json['isRead']),
      isLiked: cvToBool(json['isLiked']),
      isHide: cvToBool(json['isHide']),
      isReply: cvToBool(json['isReply']),
      adminReply: cvToString(json['adminReply']),
      dateSubmit: cvToDate(json['dateSubmit']),
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}
