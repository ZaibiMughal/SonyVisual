import 'package:flutter/material.dart';

import '../config/main_config.dart';

class ScreenError{
  String title;
  String message;
  Icon icon;

  ScreenError({this.title = "Sorry", this.message = "Something went wrong!", this.icon = Config.errorIcon, });
}