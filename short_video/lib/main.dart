import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:short_video/config/colors_config.dart';
import 'package:short_video/providers/ad_provider.dart';
import 'package:short_video/providers/connection_provider.dart';
import 'package:short_video/providers/timer_provider.dart';
import 'package:short_video/screens/TTSplashScreen.dart';

void main() async {

  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox("sonyVisual");

  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConnectionProvider>(
          create: (context) => ConnectionProvider(),
        ),
        ChangeNotifierProvider<TimerProvider>(
          create: (context) => TimerProvider(),
        ),
        ChangeNotifierProvider<AdProvider>(
          create: (context) => AdProvider(),
        )
      ],
      child: MaterialApp(
        title: 'SonyVisual',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorsConfig.p_color),
          useMaterial3: true,
        ),
        home: TTSplashScreen(),
      ),
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

