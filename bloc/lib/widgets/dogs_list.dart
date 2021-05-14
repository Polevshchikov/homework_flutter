import 'package:bloc_network_example/cubit/dog_cubit.dart';
import 'package:bloc_network_example/cubit/dog_state.dart';
import 'package:bloc_network_example/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'action_buttons.dart';

class DogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DogCubit, DogState>(
      builder: (context, state) {
        if (state is DogLoadingState) {
          DogCubit dogCubit = context.read<DogCubit>();
          dogCubit.fetchDogs();
          return Center(child: CircularProgressIndicator());
        }

        if (state is DogLoadedState) {
          return ListView.builder(
            itemCount: state.loadedDog.length,
            itemBuilder: (context, index) => Container(
              color: index % 2 == 0 ? Colors.white : Colors.blue[50],
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        breed: state.loadedDog[index].breed,
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(
                    '${state.loadedDog[index].breed}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: state.loadedDog[index].subBreeds.isEmpty
                      ? null
                      : Text(
                          '${state.loadedDog[index].subBreeds.join(', ')}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
          );
        }

        if (state is DogErrorState) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 200.0,
                ),
                Text(
                  'Не удалось получить данные',
                  style: TextStyle(fontSize: 20.0),
                ),
                ActionButtons(),
              ],
            ),
          );
        }
        return null;
      },
    );
  }
}
