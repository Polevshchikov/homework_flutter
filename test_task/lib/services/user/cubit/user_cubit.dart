import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/services/user/cubit/user_state.dart';
import 'package:test_task/services/user/models/user.dart';
import 'package:test_task/services/user/user_repository.dart';

class UserCubit extends Cubit<UserState> {
  final UsersRepository usersRepository;

  UserCubit(this.usersRepository) : super(UserLoadingState());

  Future<void> fetchUsers() async {
    try {
      final List<User> _loadedUserList = await usersRepository.getAllUsers();
      emit(UserLoadedState(loadedUser: _loadedUserList));
    } catch (_) {
      emit(UserErrorState());
    }
  }
}
