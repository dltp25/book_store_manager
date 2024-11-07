part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final bool isLoading;
  final NotiViewType viewType;
  final List<NotificationModel> notis;
  final int number;

  const NotificationState({
    this.isLoading = true,
    this.viewType = NotiViewType.all,
    this.notis = const [],
    this.number = 20,
  });

  @override
  List<Object> get props => [isLoading, viewType, notis, number];

  NotificationState copyWith({
    bool? isLoading,
    NotiViewType? viewType,
    List<NotificationModel>? notis,
    int? number,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      viewType: viewType ?? this.viewType,
      notis: notis ?? this.notis,
      number: number ?? this.number,
    );
  }
}
