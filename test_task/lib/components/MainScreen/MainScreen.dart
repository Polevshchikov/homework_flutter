import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/components/MainScreen/elements/user_list.dart';
import 'package:test_task/services/user/cubit/user_cubit.dart';
import 'package:test_task/services/user/user_repository.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final usersRepository = UsersRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (context) => UserCubit(usersRepository),
      child: Scaffold(
        body: UserList(),
      ),
    );
  }
}
