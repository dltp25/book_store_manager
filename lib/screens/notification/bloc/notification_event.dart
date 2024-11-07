part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class LoadNotificationEvent extends NotificationEvent {
  final NotiViewType type;

  const LoadNotificationEvent({required this.type});
}

class StreamUpdateEvent extends NotificationEvent {
  final List<NotificationModel> notis;

  const StreamUpdateEvent({required this.notis});
}

class LoadMoreNotiEvent extends NotificationEvent {}

class MarkAllAsReadEvent extends NotificationEvent {}

class ReadNotificationEvent extends NotificationEvent {
  final String notiId;
  final bool isRead;

  const ReadNotificationEvent({required this.notiId, required this.isRead});
}
