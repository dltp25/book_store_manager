part of 'user_report_bloc.dart';

sealed class UserReportEvent extends Equatable {
  const UserReportEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends UserReportEvent {}

class HideFeedbackEvent extends UserReportEvent {
  final String feedbackId;

  const HideFeedbackEvent({required this.feedbackId});
}

class ReadReportEvent extends UserReportEvent {
  final String reportId;

  const ReadReportEvent({required this.reportId});
}
