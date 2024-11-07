part of 'logging_bloc.dart';

class LoggingState extends Equatable {
  final DateTime? selectedDate;

  const LoggingState({this.selectedDate});

  @override
  List<Object?> get props => [selectedDate];

  LoggingState copyWith({
    DateTime? selectedDate,
  }) {
    return LoggingState(
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
