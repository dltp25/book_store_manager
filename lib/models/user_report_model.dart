class UserReportModel {
  final String id;
  final String feedbackId;
  final String report;
  final int status;
  final DateTime date;
  final String feedbackAvatar;
  final bool feedbackIsHide;
  final String feedbackReview;
  final String feedbackUserName;
  final int feedbackRating;

  UserReportModel({
    required this.id,
    required this.feedbackId,
    required this.report,
    required this.status,
    required this.date,
    required this.feedbackAvatar,
    required this.feedbackIsHide,
    required this.feedbackReview,
    required this.feedbackUserName,
    required this.feedbackRating,
  });
}
