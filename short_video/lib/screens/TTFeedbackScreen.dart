import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTWidgets.dart';

class TTFeedbackScreen extends StatefulWidget {
  static String tag = '/TTFeedbackScreen';

  @override
  TTFeedbackScreenState createState() => TTFeedbackScreenState();
}

class TTFeedbackScreenState extends State<TTFeedbackScreen> {
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
      appBar: ttAppBar(context, "Feedback") as PreferredSizeWidget?,
      backgroundColor: black,
      body: Responsive(
        mobile: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Text("If there is anything I can do for you to make your app experience better,I'll be glad to do so.", style: primaryTextStyle(color: white)),
              16.height,
              ttEditTextStyle("Please write your concern here"),
              26.height,
              Text("Contact Information", style: primaryTextStyle(color: white)),
              8.height,
              ttEditTextStyle("Your Email Address"),
              16.height,
              ttEditTextStyle("Your Phone Number", keyboardType: TextInputType.phone),
              24.height,
              TextButton(
                onPressed: () {
                  toast("Submit");
                  finish(context);
                },
                child: Container(
                    padding: EdgeInsets.only(top: 6, bottom: 6, left: 20, right: 20),
                    decoration: boxDecorationWithRoundedCorners(borderRadius: BorderRadius.circular(4), backgroundColor: TTColorRed),
                    child: Text('Submit', textAlign: TextAlign.center, style: primaryTextStyle(color: white))),
              ).center(),
            ],
          ).paddingAll(10),
        ),
      ),
    );
  }
}
