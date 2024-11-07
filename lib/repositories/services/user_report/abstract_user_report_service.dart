import '../../../models/user_report_model.dart';

abstract class AbstractUserReportService {
  Future<List<UserReportModel>> getUserReport(int status);

  Future<Map<String, dynamic>> getFeedbackInfor(String feedbackId);

  Future<void> readReport(String reportId);

  Future<void> hideFeedback(String feedbackId);
}
