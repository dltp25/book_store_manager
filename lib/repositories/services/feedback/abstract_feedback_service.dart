import '../../../constant/enum.dart';
import '../../../models/feedback_model.dart';
import '../../../models/user_model.dart';

abstract class AbstractFeedbackService {
  Future<List<FeedbackModel>> getFeedback(
      ManageFeedbackType type, DateTime month);

  Future<UserLiteModel> getUserLiteModel(String userId);

  Future<void> likeFeedback(String feedbackId, bool like);

  Future<void> readFeedback(String feedbackId, bool read);

  Future<void> hideFeedback(String feedbackId, bool hide);

  Future<void> unHideFeedback(String feedbackId);

  Future<void> replyFeedback(String feedbackId, String reply);

  Future<List<FeedbackModel>> getHideFeedback();

  Future<List<FeedbackModel>> getFeedbackOfProduct(String productId);
}
