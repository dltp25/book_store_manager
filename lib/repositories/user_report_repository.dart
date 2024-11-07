import 'package:book_store_manager/models/user_report_model.dart';
import 'package:book_store_manager/repositories/services/user_report/user_report_service.dart';

import 'services/user_report/abstract_user_report_service.dart';

class UserReportRepository {
  late AbstractUserReportService _reportService;

  UserReportRepository() {
    _reportService = UserReportService();
  }

  Future<List<UserReportModel>> getUserReport(int status) async {
    return _reportService.getUserReport(status);
  }

  Future<void> readReport(String reportId) async {
    return _reportService.readReport(reportId);
  }

  Future<void> hideFeedback(String feedbackId) async {
    return _reportService.hideFeedback(feedbackId);
  }
}
