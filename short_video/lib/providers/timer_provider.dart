
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

import '../utils/utils.dart';

class TimerProvider extends ChangeNotifier{

  double currentTime = 0.0;
  bool isVideoFinished = false;

  setCurrentTime(double value){
    currentTime = value;
    notifyListeners();
  }

  getCurrentTime(){
    return currentTime;
  }

  setIsVideoFinished(bool value){
    isVideoFinished = value;
    notifyListeners();
  }

  getIsVideoFinished(){
    return isVideoFinished;
  }
}