
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

import '../utils/utils.dart';

class AdProvider extends ChangeNotifier{

  bool isLoaded = false;

  setIsAdLoaded(bool value){
    isLoaded = value;
    notifyListeners();
  }

  getIsAdLoaded(){
    return isLoaded;
  }
}