import 'package:test_task/services/user/models/user.dart';
import 'package:test_task/services/user/user_api_provider.dart';

class UsersRepository {
  UserProvider _usersProvider = UserProvider();
  Future<List<User>> getAllUsers() => _usersProvider.getUser();
}
