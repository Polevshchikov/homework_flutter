import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/services/user/cubit/user_cubit.dart';
import 'package:test_task/theme/ColorPalette.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserCubit userCubit = context.read<UserCubit>();
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width * 0.62,
      height: 38.0,
      elevation: 3,
      color: colorButtonActiv,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        'Обновить',
        style: TextStyle(
          color: colorWhite,
          fontSize: 16.0,
        ),
      ),
      onPressed: () {
        userCubit.fetchUsers();
      },
    );
  }
}
