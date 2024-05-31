import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/screens/TTDashboardScreen.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTWidgets.dart';

class TTOtpScreen extends StatefulWidget {
  static String tag = '/TTOtpScreen';

  @override
  TTOtpScreenState createState() => TTOtpScreenState();
}

class TTOtpScreenState extends State<TTOtpScreen> {
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
                  Text('Enter OTP', style: boldTextStyle(color: white, size: 18)),
                  16.height,
                  PinEntryTextField(fields: 6, showFieldAsBox: true, fontSize: 16),
                  16.height,
                  Text('Resend OTP', style: boldTextStyle(color: TTColorRed, size: 18)),
                  16.height,
                ],
              ).center(),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () {
                    TTDashboardScreen().launch(context);
                  },
                  child: Container(
                      width: context.width(),
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      decoration: boxDecorationWithRoundedCorners(borderRadius: BorderRadius.circular(4), backgroundColor: TTColorRed),
                      child: Text('Submit', textAlign: TextAlign.center, style: primaryTextStyle(color: white))),
                ),
              ),
            ],
          ),
        ));
  }
}
