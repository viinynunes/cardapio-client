import 'package:cardapio/modules/core/connectivity/usecases/i_connectivity_usecase.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityUsecaseImpl implements IConnectivityUsecase {
  @override
  Future<bool> checkConnectivity() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
