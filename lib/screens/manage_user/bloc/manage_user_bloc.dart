import 'package:bloc/bloc.dart';
import 'package:book_store_manager/models/user_model.dart';
import 'package:book_store_manager/repositories/user_repository.dart';
import 'package:diacritic/diacritic.dart';
import 'package:equatable/equatable.dart';

part 'manage_user_event.dart';
part 'manage_user_state.dart';

class ManageUserBloc extends Bloc<ManageUserEvent, ManageUserState> {
  final UserRepository _userRepository;

  ManageUserBloc(this._userRepository) : super(const ManageUserState()) {
    on<InitialEvent>(_onInitial);
    on<SearchingEvent>(_onSearching);
  }

  _onInitial(InitialEvent event, Emitter emit) async {
    List<UserModel> users = await _userRepository.getAllUsers();

    emit(state.copyWith(
      isLoading: false,
      allUsers: users,
      showedUsers: users,
    ));
  }

  _onSearching(SearchingEvent event, Emitter emit) {
    List<UserModel> allUsers = List.from(state.allUsers);

    if (event.query.isEmpty) {
      emit(state.copyWith(
        showedUsers: allUsers,
      ));
    } else {
      List<UserModel> showed = [];

      for (var ele in allUsers) {
        if (removeDiacritics(ele.name.toLowerCase())
            .contains(removeDiacritics(event.query.toLowerCase()))) {
          showed.add(ele);
        }
      }

      emit(state.copyWith(showedUsers: showed));
    }
  }
}
