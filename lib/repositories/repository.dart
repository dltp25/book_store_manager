import 'user_report_repository.dart';

import 'import_repository.dart';
import 'notification_repository.dart';
import 'user_repository.dart';

import 'feedback_repository.dart';
import 'order_repository.dart';
import 'product_repository.dart';

class AppRepository {
  late ProductRepository productRepository;
  late OrderRepository orderRepository;
  late UserRepository userRepository;
  late ImportRepository importRepository;
  late NotificationRepository notiRepository;
  late FeedbackRepository feedbackRepository;
  late UserReportRepository reportRepository;

  AppRepository() {
    productRepository = ProductRepository();
    orderRepository = OrderRepository();
    userRepository = UserRepository();
    importRepository = ImportRepository();
    notiRepository = NotificationRepository();
    feedbackRepository = FeedbackRepository();
    reportRepository = UserReportRepository();
  }
}
