part of 'user_report_bloc.dart';

class UserReportState extends Equatable {
  final bool isLoading;
  final List<UserReportModel> reports;

  const UserReportState({
    this.isLoading = true,
    this.reports = const [],
  });

  @override
  List<Object> get props => [isLoading, reports];

  UserReportState copyWith({bool? isLoading, List<UserReportModel>? reports}) {
    return UserReportState(
      isLoading: isLoading ?? this.isLoading,
      reports: reports ?? this.reports,
    );
  }
}
