import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/business_logic/app_state.dart';
import 'package:short_video/business_logic/bloc/user_bloc.dart';
import 'package:short_video/screens/TTChooseLanguageScreen.dart';
import 'package:short_video/screens/TTDashboardScreen.dart';
import 'package:short_video/screens/TTFeedbackScreen.dart';
import 'package:short_video/screens/TTSignInScreen.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTConstant.dart';
import 'package:short_video/utils/TTWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../business_logic/services/network_service_response.dart';
import '../config/main_config.dart';
import '../config/toast_config.dart';
import 'TTAboutUsScreen.dart';

class TTSettingScreen extends StatefulWidget {
  static String tag = '/TTSettingScreen';

  @override
  TTSettingScreenState createState() => TTSettingScreenState();
}

class TTSettingScreenState extends State<TTSettingScreen> {
  bool isSwitched = false;

  UserBloc bloc = UserBloc();

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

  Future<bool> delete() async {
    hideKeyboard(context);
    Loader().launch(context);
    NetworkServiceResponse response =  await bloc.actionDelete();
    Navigator.pop(context);
    if(response.status ==  Status.Error){
      ToastConfig.showToast(title: 'Error', message: response.message, context: context);
      return false;
    } else {
      ToastConfig.showToast(title: 'Success', message: "Account Deleted Successfully", context: context, alertType: AlertType.success);
      return true;
    }
  }


  @override
  Widget build(BuildContext context) {
    Widget mOption(var icon, var value, {Color color = white}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [Icon(icon, color: color), 10.width, Text(value, style: primaryTextStyle(color: color))],
          ),
          Icon(Icons.chevron_right, color: color),
        ],
      ).paddingAll(16);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        appBar: ttAppBar(context, "Settings") as PreferredSizeWidget?,
        body: Responsive(
          mobile: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                Text("GENERAL",
                    style: boldTextStyle(
                      color: white,
                    )).paddingOnly(left: 16),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Icon(Icons.notifications_none_outlined, color: white),
                //     10.width,
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         20.height,
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text("Notification", style: primaryTextStyle(color: white)),
                //             Switch(
                //               value: isSwitched,
                //               onChanged: (value) {
                //                 setState(() {
                //                   isSwitched = value;
                //                   print(isSwitched);
                //                 });
                //               },
                //               activeTrackColor: Colors.white24,
                //               activeColor: TTColorRed,
                //               inactiveTrackColor: Colors.white24,
                //             ),
                //           ],
                //         ),
                //         Text("If you disable notification,you won't get latest updates from your followers.", style: secondaryTextStyle(color: Colors.white54)),
                //       ],
                //     ).expand(),
                //   ],
                // ).paddingOnly(left: 16, right: 16),
                // mOption(Icons.language, "Change Language").onTap(() {
                //   TTChooseLanguageScreen().launch(context);
                // }),
                Divider(color: Colors.white24).paddingOnly(left: 16, right: 16),
                // mOption(Icons.feedback, "Feedback").onTap(() {
                //   TTFeedbackScreen().launch(context);
                // }),
                mOption(Icons.star_border, "Rate" + " " + TTAppName).onTap(() async {
                  const url = 'https://www.google.com';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }),
                mOption(Icons.share_outlined, "Share" + " " + TTAppName).onTap(() {
                  onShareTap(context);
                }),
                mOption(Icons.info_outline, "About Us").onTap(() {
                  TTAboutUsScreen().launch(context);
                }),
                Divider(color: Colors.white24).paddingOnly(left: 16, right: 16),
                mOption(Icons.logout, "Logout").onTap(() async {
                  bool? res = await showConfirmDialog(context, 'Do you want to logout?');
                  if (res ?? false) {
                    AppCurrentState.instance.logout();
                    TTSignINScreen().launch(context, isNewTask: true);
                  }
                }),
                mOption(Icons.delete, "Delete", color: redColor).onTap(() async {
                  bool? res = await showConfirmDialog(context, 'Do you want to delete this account?');
                  if (res ?? false) {
                    bool result = await delete();
                    if(result) {
                      TTSignINScreen().launch(context, isNewTask: true);
                    }
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
