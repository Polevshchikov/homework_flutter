import 'package:flutter/foundation.dart';
import 'package:test_task/services/user/models/user.dart';

abstract class UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  List<User> loadedUser;
  UserLoadedState({@required this.loadedUser}) : assert(loadedUser != null);
}

class UserErrorState extends UserState {}
