import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/screens/TTSignInScreen.dart';
import 'package:short_video/utils/TTConstant.dart';
import 'package:short_video/utils/TTImages.dart';

import 'TTDashboardScreen.dart';
import 'TTLanguageSelectionScreen.dart';

class TTSplashScreen extends StatefulWidget {
  static String tag = '/TTSplashScreen';

  @override
  TTSplashScreenState createState() => TTSplashScreenState();
}

class TTSplashScreenState extends State<TTSplashScreen> with AfterLayoutMixin<TTSplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  Future checkFirstSeen() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool _seen = (prefs.getBool('seen') ?? false);

    await Future.delayed(Duration(seconds: 2));
    finish(context);
    TTSignINScreen().launch(context);

    //
    // if (_seen) {
    //   await Future.delayed(Duration(seconds: 2));
    //   finish(context);
    //   TTDashboardScreen().launch(context);
    // } else {
    //   await prefs.setBool('seen', true);
    //   await Future.delayed(Duration(seconds: 2));
    //   finish(context);
    //   TTLanguageSelection().launch(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    //changeStatusColor(black);

    return Scaffold(
      backgroundColor: black, 
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(decoration: boxDecorationWithRoundedCorners(borderRadius: radius(16)), child: Image.asset(TT_ic_logo, height: 80).cornerRadiusWithClipRRect(16)),
          8.height,
          Text(TTAppName, style: boldTextStyle(size: 25, color: Colors.white)),
        ],
      ).center(),
    );
  }
}
