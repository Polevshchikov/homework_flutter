import 'package:bloc_network_example/models/dog.dart';
import 'package:bloc_network_example/services/dog_api_provider.dart';

class DogsRepository {
  DogProvider _dogsProvider = DogProvider();

  Future<List<Dogs>> getAllDogs() => _dogsProvider.getDogs();
}
