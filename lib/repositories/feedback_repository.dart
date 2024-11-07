import 'package:book_store_manager/constant/enum.dart';
import 'package:book_store_manager/repositories/services/feedback/feedback_service.dart';

import '../models/feedback_model.dart';
import 'services/feedback/abstract_feedback_service.dart';

class FeedbackRepository {
  late AbstractFeedbackService _feedbackService;

  FeedbackRepository() {
    _feedbackService = FeedbackService();
  }

  Future<List<FeedbackModel>> getFeedback(
      ManageFeedbackType type, DateTime month) async {
    return _feedbackService.getFeedback(type, month);
  }

  Future<void> likeFeedback(String feedbackId, bool like) async {
    return _feedbackService.likeFeedback(feedbackId, like);
  }

  Future<void> readFeedback(String feedbackId, bool read) async {
    return _feedbackService.readFeedback(feedbackId, read);
  }

  Future<void> hideFeedback(String feedbackId, bool hide) async {
    return _feedbackService.hideFeedback(feedbackId, hide);
  }

  Future<void> replyFeedback(String feedbackId, String reply) async {
    return _feedbackService.replyFeedback(feedbackId, reply);
  }

  Future<List<FeedbackModel>> getHideFeedback() async {
    return _feedbackService.getHideFeedback();
  }

  Future<List<FeedbackModel>> getFeedbackOfProduct(String productId) async {
    return _feedbackService.getFeedbackOfProduct(productId);
  }
}
