import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTConstant.dart';
import 'package:short_video/utils/TTWidgets.dart';

class TTAboutUsScreen extends StatefulWidget {
  static String tag = '/TTAboutUsScreen';

  @override
  TTAboutUsScreenState createState() => TTAboutUsScreenState();
}

class TTAboutUsScreenState extends State<TTAboutUsScreen> {
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
      appBar: ttAppBar(context, "About us") as PreferredSizeWidget?,
      backgroundColor: black,
      body: Responsive(
        mobile: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TTAppName, style: primaryTextStyle(color: white)),
              16.height,
              Text("For more information please visit:", style: primaryTextStyle(color: white)),
              Text("coding@${TTAppName.toLowerCase()}@.com", style: primaryTextStyle(color: TTColorSerpent)),
              // 16.height,
              // Text("Client ID:", style: primaryTextStyle(color: white)),
              // Text("28375-64f658-452414474099", style: primaryTextStyle(color: white)),
              16.height,
              Text("Terms of Use", style: primaryTextStyle(color: TTColorSerpent)),
              16.height,
              Text("Privacy Policy", style: primaryTextStyle(color: TTColorSerpent)),
            ],
          ).paddingAll(10),
        ),
      ),
    );
  }
}
