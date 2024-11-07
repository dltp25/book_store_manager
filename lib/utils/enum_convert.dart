import 'package:book_store_manager/constant/enum.dart';

class EnumConvert {
  static String feedbackToString(FeedbackViewType type) {
    switch (type) {
      case FeedbackViewType.all:
        return 'Tất cả';
      case FeedbackViewType.one:
        return '1 sao';
      case FeedbackViewType.two:
        return '2 sao';
      case FeedbackViewType.three:
        return '3 sao';
      case FeedbackViewType.four:
        return '4 sao';
      case FeedbackViewType.five:
        return '5 sao';
    }
  }

  static int feedbackToInt(FeedbackViewType type) {
    switch (type) {
      case FeedbackViewType.all:
        return 0;
      case FeedbackViewType.one:
        return 1;
      case FeedbackViewType.two:
        return 2;
      case FeedbackViewType.three:
        return 3;
      case FeedbackViewType.four:
        return 4;
      case FeedbackViewType.five:
        return 5;
      default:
        throw Exception('Invalid FeedbackViewType');
    }
  }
}
