class ReplyNotificationModel {
  final String actionCode;
  final String content;
  final String title;
  final bool isRead;
  final DateTime date;

  ReplyNotificationModel({
    required this.actionCode,
    required this.content,
    required this.title,
    required this.isRead,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'actionCode': actionCode,
      'content': content,
      'title': title,
      'date': date,
      'isRead': isRead,
    };
  }
}
