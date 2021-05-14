import 'package:bloc_network_example/cubit/dog_state.dart';
import 'package:bloc_network_example/models/dog.dart';
import 'package:bloc_network_example/services/dog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogCubit extends Cubit<DogState> {
  final DogsRepository dogsRepository;

  DogCubit(this.dogsRepository) : super(DogLoadingState());

  Future<void> fetchDogs() async {
    try {
      final List<Dogs> _loadedDogList = await dogsRepository.getAllDogs();

      emit(DogLoadedState(loadedDog: _loadedDogList));
    } catch (_) {
      emit(DogErrorState());
    }
  }
}
