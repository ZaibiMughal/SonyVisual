import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTImages.dart';

import 'TTSignInScreen.dart';

class TTErrorSignInScreen extends StatefulWidget {
  static String tag = '/TTErrorSignInScreen';

  @override
  TTErrorSignInScreenState createState() => TTErrorSignInScreenState();
}

class TTErrorSignInScreenState extends State<TTErrorSignInScreen> {
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
    return Scaffold(
      backgroundColor: black,
      body: Responsive(
        mobile: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(TT_ic_person_face, width: 50, height: 50, color: white),
                16.height,
                Text("Sign in to your profile", style: primaryTextStyle(color: white)),
                4.height,
                Text("Sign in & follow profiles to see their videos here", style: secondaryTextStyle(color: white)),
              ],
            ).center(),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  TTSignINScreen().launch(context);
                },
                child: Container(
                    width: context.width(),
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.only(top: 6, bottom: 6),
                    decoration: boxDecorationWithRoundedCorners(borderRadius: BorderRadius.circular(4), backgroundColor: TTColorRed),
                    child: Text('Sign In', textAlign: TextAlign.center, style: primaryTextStyle(color: white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
