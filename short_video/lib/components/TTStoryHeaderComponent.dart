import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/screens/TTErrorSignInScreen.dart';
import 'package:short_video/utils/TTConstant.dart';

class TTStoryHeaderComponent extends StatefulWidget {
  static String tag = '/TTStoryHeaderComponent';

  @override
  TTStoryHeaderComponentState createState() => TTStoryHeaderComponentState();
}

class TTStoryHeaderComponentState extends State<TTStoryHeaderComponent> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text('Following', style: boldTextStyle(color: white, size: 18)).paddingRight(16).onTap(() {
            //   TTErrorSignInScreen().launch(context);
            // }),
            // Container(decoration: BoxDecoration(shape: BoxShape.circle, color: white), width: 6, height: 6),
            Text(TTAppName, style: boldTextStyle(color: white, size: 18)).paddingLeft(16)
          ],
        ).paddingAll(16),
      ),
    );
  }
}
