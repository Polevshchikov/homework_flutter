import 'package:connectivity/connectivity.dart';
import 'package:di/model/cat.dart';
import 'package:di/service/cat_api_provider.dart';
import 'package:di/service/mock_repository.dart';

class GetCat {
  final Connectivity connectivity;

  GetCat({this.connectivity});

  Future<Cat> getData() async {
    var connectivityResult = await (connectivity.checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      final catFactory = mockClientCat()
          .then((response) => response)
          .catchError((onError) => null);
      return catFactory;
    } else {
      final catFactory = fetchCatFactory()
          .then((response) => response)
          .catchError((onError) => null);

      return catFactory;
    }
  }
}
