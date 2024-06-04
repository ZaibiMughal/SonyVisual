import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/config/colors_config.dart';

enum Status { Loading, Done, Error, Idle }

class Config {
  Config._();

  static const bool debugging = false;
  static String appName = 'SonyVisual';
  static const String version = '1.0';
  static const String defaultFontFamily = 'GOTHIC';
  static const String translationPath = 'assets/translations';
  static const Locale defaultLanguage = Locale('en','US');
  static const List<Locale> languageList = [
    Locale('en','US'),
    Locale('es','ES'),
  ];

  /// Local Storage Keys
  static const String isLoggedIn = "isLoggedIn";
  static const String lastLoggedInTime = "lastLoggedInTime";
  static const String userStorageKey = 'local-user';

  /// Http Methods
  static const String HTTP_GET = "GET";
  static const String HTTP_POST = "POST";
  static const String HTTP_PUT = "PUT";
  static const String HTTP_DELETE = "DELETE";
  static const String HTTP_DOWNLOAD = "DOWNLOAD";

  static const String API_URL = "https://admin.sonyvisual.com/api/";

  static InputDecoration inputDecoration({String? labelText, String? hintText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: secondaryTextStyle(),
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      hintText: hintText,
      hintStyle: secondaryTextStyle(),
      border: OutlineInputBorder(),
      alignLabelWithHint: true,
    );
  }

  static const Icon errorIcon = Icon(
    Icons.error_outline,
    size: 70,
  );

  static TextStyle textStyle = TextStyle(color: ColorsConfig.p_textColor);


  static const String androidAdMobId = 'ca-app-pub-3940256099942544~3347511713';
  static const String androidAdMobBannerUnitId =
      'ca-app-pub-3940256099942544/6300978111';
  static const String androidAdMobInterstitialUnitId =
      'ca-app-pub-3940256099942544/1033173712';
  static const String iOSAdMobId = 'ca-app-pub-7617934641401276~9607996786';
  static const String iOSAdMobBannerUnitId = 'ca-app-pub-3940256099942544/2934735716';
  static const String iOSAdMobInterstitialUnitId = 'ca-app-pub-3940256099942544/4411468910';
}
