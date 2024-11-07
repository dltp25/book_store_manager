part of 'logging_bloc.dart';

sealed class LoggingEvent extends Equatable {
  const LoggingEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends LoggingEvent {}

class UpdateSelectedDateEvent extends LoggingEvent {
  final DateTime selectedDate;

  const UpdateSelectedDateEvent({required this.selectedDate});
}
