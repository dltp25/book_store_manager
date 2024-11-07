part of 'root_bloc.dart';

class RootState {
  final bool isLoading;
  final bool isAdmin;

  RootState({
    this.isLoading = true,
    this.isAdmin = false,
  });

  RootState copyWith({bool? isLoading, bool? isAdmin}) {
    return RootState(
      isAdmin: isAdmin ?? this.isAdmin,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
