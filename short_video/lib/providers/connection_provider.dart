
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

import '../utils/utils.dart';

class ConnectionProvider extends ChangeNotifier{

  bool? isOnline;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;


  initialize() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await Utils.getConnectivityStatus();
      // result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future initConnectivity() async {
    initialize();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus = result;
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
    notifyListeners();
  }

  bool checkIsOnline(){

    return Utils.isOnline(_connectionStatus);
    // return _connectionStatus.contains(ConnectivityResult.mobile) ||
    //     _connectionStatus.contains(ConnectivityResult.wifi) ||
    //     _connectionStatus.contains(ConnectivityResult.ethernet) ||
    //     _connectionStatus.contains(ConnectivityResult.vpn);
  }
}