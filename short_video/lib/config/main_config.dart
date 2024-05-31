import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/config/colors_config.dart';

class Config {
  Config._();

  static const bool debugging = false;
  static String appName = 'app_name';
  static const String version = '1.0';
  static const String defaultFontFamily = 'GOTHIC';
  static const String translationPath = 'assets/translations';
  static const Locale defaultLanguage = Locale('en','US');
  static const List<Locale> languageList = [
    Locale('en','US'),
    Locale('es','ES'),
  ];

  /// Default DateTime Format
  static const String dateFormat = 'dd-MM-yyyy hh:mm:ss';

  /// iOS App No
  static const String iOSAppStoreId = '000000000000';

  /// Facebook Key
  static const String fbKey = '0000000000000000';

  ///Google Admob
  static const bool showAdMob = true;
  static const String androidAdMobId = 'ca-app-pub-3940256099942544~3347511713';
  static const String androidAdMobBannerUnitId =
      'ca-app-pub-3940256099942544/6300978111';
  static const String androidAdMobInterstitialUnitId =
      'ca-app-pub-3940256099942544/1033173712';
  static const String iOSAdMobId = 'ca-app-pub-7617934641401276~9607996786';
  static const String iOSAdMobBannerUnitId = 'ca-app-pub-3940256099942544/2934735716';
  static const String iOSAdMobInterstitialUnitId = 'ca-app-pub-3940256099942544/4411468910';

  ///SQL Lite DB Name
  static const String dbName = 'local_storage.storage';

  ///SQL Lite DB Exceptions
  static String dbClosedError = 'database_connection_closed';
  static String dbDuplicateColumnError = 'database_duplicate_column';
  static String dbTableError = 'database_no_table';
  static String dbNotNullError = 'database_not_null';
  static String dbOpenFailedError = 'database_open_failed';
  static String dbReadOnlyError = 'database_read_only';
  static String dbSyntaxError = 'database_syntax';
  static String dbUniqueError = 'database_unique';
  static String dbException = 'database_error';


  /// Main Logo
  static const String logoPath = 'assets/images/logo.png';
  static const String defaultProfileImage = 'assets/images/default_profile.png';
  static const String defaultPlaceHolder = 'assets/images/place_holder.png';
  static const String loaderPath = 'assets/loader.json';

  /// Border Radius
  static const double borderRadius = 8.0;
  static BorderRadius borderRadiusCircular = BorderRadius.circular(Config.borderRadius);
  static const double circularBorderRadius = 16.0;

  static const EdgeInsets bodyPadding = EdgeInsets.symmetric(vertical: 16, horizontal: 12);
  static const EdgeInsets boxPadding = EdgeInsets.all(8);

  static const double iconButtonSize = 30;
  static const double iconSize = 18;


  // Button Size
  static const double btnHeight = 40;
  static const double btnWidth = 20;


  /// Local Storage Keys
  static const String isLoggedIn = "isLoggedIn";
  static const String lastLoggedInTime = "lastLoggedInTime";
  static const String userStorageKey = 'local-user';
  static const String loremIspemKey = 'lorem-ispem';

  /// Exceptions
  // static const socketException = 1; // Will be thrown when the domain or url is not responsive
  // static const formatException = 2; // Will be thrown when the response is not json
  // static const invalidArgumentException = 3; // Will be when a header is not given as string
  // static const divisionByZeroException = 4;
  // static const tokenException = 5; // Will be thrown when the token is empty or null
  // static const notKnownException = 6;

  /// Http Methods
  static const String HTTP_GET = "GET";
  static const String HTTP_POST = "POST";
  static const String HTTP_PUT = "PUT";
  static const String HTTP_DELETE = "DELETE";
  static const String HTTP_DOWNLOAD = "DOWNLOAD";


  /// Icons
  static const Icon errorIcon = Icon(
    Icons.error_outline,
    size: 70,
  );

  /// ONE SIGNAL push notifications Rest Conf
  static const String oneSignalAppId = "94838bb4-a89d-4791-8177-de1b54516b87";
  static const String oneSignalRestKey = "ODk2Y2IxMDktYTJmYS00NzYzLTgwMDMtMTNhODUzZWU1MWY1";
  static const String oneSignalChannelId = "oneSignalChannelId";

  static const firebaseStorageAppId = 'flutter-structure-e8f95.appspot.com';
  static const oneSignalAppIconUrl = 'https://firebasestorage.googleapis.com/v0/b/$firebaseStorageAppId/o/app_logo.png?alt=media&token=55faf2c8-84ca-4776-80aa-c67222e58ff8';


  static InputDecoration inputDecoration({String? labelText, String? hintText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: secondaryTextStyle(),
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      hintText: hintText,
      hintStyle: secondaryTextStyle(),
      border: OutlineInputBorder(),
      // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsConfig.p_color.withOpacity(0.5)), borderRadius: BorderRadius.circular(defaultRadius)),
      // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsConfig.p_color), borderRadius: BorderRadius.circular(defaultRadius)),
      // errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(defaultRadius)),
      // focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(defaultRadius)),
      alignLabelWithHint: true,
    );
  }

  static TextStyle textStyle = TextStyle(color: ColorsConfig.p_textColor);
}
