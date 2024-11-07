part of 'manage_user_bloc.dart';

sealed class ManageUserEvent extends Equatable {
  const ManageUserEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends ManageUserEvent {}

class SearchingEvent extends ManageUserEvent {
  final String query;

  const SearchingEvent({required this.query});
}
