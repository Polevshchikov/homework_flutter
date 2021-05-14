import 'package:bloc_network_example/cubit/dog_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DogCubit dogCubit = context.read<DogCubit>();
    return ElevatedButton(
      child: Text('Повторить'),
      onPressed: () {
        dogCubit.fetchDogs();
      },
    );
  }
}
