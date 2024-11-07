part of 'manage_user_bloc.dart';

class ManageUserState extends Equatable {
  final bool isLoading;
  final List<UserModel> allUsers;
  final List<UserModel> showedUsers;

  const ManageUserState({
    this.isLoading = true,
    this.allUsers = const [],
    this.showedUsers = const [],
  });

  @override
  List<Object> get props => [isLoading, allUsers, showedUsers];

  ManageUserState copyWith({
    bool? isLoading,
    List<UserModel>? allUsers,
    List<UserModel>? showedUsers,
  }) {
    return ManageUserState(
      isLoading: isLoading ?? this.isLoading,
      allUsers: allUsers ?? this.allUsers,
      showedUsers: showedUsers ?? this.showedUsers,
    );
  }
}
