import 'package:bloc_network_example/cubit/dog_cubit.dart';
import 'package:bloc_network_example/services/dog_repository.dart';
import 'package:bloc_network_example/widgets/dogs_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final dogsRepository = DogsRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DogCubit>(
      create: (context) => DogCubit(dogsRepository),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Dogs List'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: DogList()),
          ],
        ),
      ),
    );
  }
}
