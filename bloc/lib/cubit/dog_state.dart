import 'package:bloc_network_example/models/dog.dart';
import 'package:flutter/foundation.dart';

abstract class DogState {}

class DogLoadingState extends DogState {}

class DogLoadedState extends DogState {
  List<Dogs> loadedDog;
  DogLoadedState({@required this.loadedDog}) : assert(loadedDog != null);
}

class DogErrorState extends DogState {}
