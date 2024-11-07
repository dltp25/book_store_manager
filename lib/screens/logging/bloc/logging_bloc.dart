import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'logging_event.dart';
part 'logging_state.dart';

class LoggingBloc extends Bloc<LoggingEvent, LoggingState> {
  LoggingBloc() : super(const LoggingState()) {
    on<InitialEvent>(_onInitial);
    on<UpdateSelectedDateEvent>(_onUpdateSelectedDate);
  }

  _onInitial(InitialEvent event, Emitter emit) {
    emit(state.copyWith(selectedDate: DateTime.now()));
  }

  _onUpdateSelectedDate(UpdateSelectedDateEvent event, Emitter emit) {
    if (event.selectedDate != state.selectedDate) {
      emit(state.copyWith(selectedDate: event.selectedDate));
    }
  }
}
