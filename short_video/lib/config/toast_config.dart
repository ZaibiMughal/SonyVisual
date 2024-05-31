import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_video/utils/TTWidgets.dart';

import 'colors_config.dart';


class ToastConfig {
  ToastConfig._();

  static showToast({required BuildContext context, required String title, required String message, AlertType alertType = AlertType.success}){
    context.showFlash<bool>(
      builder: (context, controller) => FlashBar(
        position : FlashPosition.top,
        controller: controller,
        indicatorColor: ColorsConfig.danger,
        icon: alertType == AlertType.error ? Icon(Icons.error, color: ColorsConfig.danger,) : Icon(Icons.check, color: ColorsConfig.success,),
        title: Text(title),
        content: Text(message),
      ),
    );
  }

}
