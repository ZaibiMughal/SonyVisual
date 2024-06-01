import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/model/TTModel.dart';
import 'package:short_video/screens/TTStoryScreen.dart';
import 'package:short_video/utils/TTDataProvider.dart';
import 'package:short_video/utils/TTWidgets.dart';

class TTNotificationScreen extends StatefulWidget {
  static String tag = '/TTNotificationScreen';

  @override
  TTNotificationScreenState createState() => TTNotificationScreenState();
}

class TTNotificationScreenState extends State<TTNotificationScreen> {
  List<TTNotificationModel> mNotificationList = getNotificationData();

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
      appBar: ttAppBar(context, "Notification", showBack: false) as PreferredSizeWidget?,
      body: Responsive(
        mobile: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: mNotificationList.length,
            padding: EdgeInsets.only(bottom: 50),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // TTStoryScreen().launch(context);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(mNotificationList[index].userImg, height: 60, width: 60, fit: BoxFit.cover).cornerRadiusWithClipRRect(8),
                    8.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(mNotificationList[index].msg, style: primaryTextStyle(color: white), maxLines: 2), 4.width, Text(mNotificationList[index].duration, style: secondaryTextStyle(color: Colors.white70))],
                    ).expand()
                  ],
                ).paddingOnly(left: 10, right: 10, top: 16),
              );
            }),
      ),
    );
  }
}
