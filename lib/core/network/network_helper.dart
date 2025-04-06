import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkHelper {
  Future<bool> isConnected();
}

class NetworkHelperImpl implements NetworkHelper {
  final Connectivity _connectivity;

  NetworkHelperImpl({required Connectivity connectivity})
    : _connectivity = connectivity;

  @override
  Future<bool> isConnected() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    }
    return false;
  }

  factory NetworkHelperImpl.create() {
    return NetworkHelperImpl(connectivity: Connectivity());
  }
}
