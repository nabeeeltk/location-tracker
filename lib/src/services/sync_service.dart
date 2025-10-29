import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:location_tracker/src/services/fierbase_service.dart';


class SyncService {
  final Connectivity _connectivity = Connectivity();
  final FirebaseService _firebase = FirebaseService();
  StreamSubscription<List<ConnectivityResult>>? _sub; // ✅ updated type

  void start() {
    _sub = _connectivity.onConnectivityChanged.listen((results) {
      // New API gives a list, check if it contains ConnectivityResult.none
      if (!results.contains(ConnectivityResult.none)) {
        _firebase.syncUnsynced();
      }
    });
  }

  void stop() {
    _sub?.cancel();
  }
}
