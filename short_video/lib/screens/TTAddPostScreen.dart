import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:short_video/screens/TTDashboardScreen.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTImages.dart';
import 'package:short_video/utils/TTStepProgressIndicator.dart';
import 'package:video_player/video_player.dart';

import '../../../main.dart';
import '../config/colors_config.dart';
import '../config/main_config.dart';
import '../utils/TTWidgets.dart';
import 'TTPickSongScreen.dart';

class TTAddPostScreen extends StatefulWidget {
  static String tag = '/TTAddPostScreen';

  @override
  TTAddPostScreenState createState() => TTAddPostScreenState();
}

class TTAddPostScreenState extends State<TTAddPostScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController videoUrlController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode titleFocus = FocusNode();
  FocusNode videoUrlFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  FocusNode descFocus = FocusNode();

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> submit() async {
    hideKeyboard(context);
    // SettingScreen().launch(context);
    // HomeScreen().launch(context);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // NetworkServiceResponse response =  await AuthService.signInWithEmail(login: Login(email: emailController.text, password: passwordController.text));
      // LoaderConfig.hideLoader();
      // if(response.status ==  Status.Error){
      //   ToastConfig.showToast(message: response.message);
      // } else {
      //   if(AppState.instance.user!.userType == UserKeys.admin){
      //     SettingScreen().launch(context, isNewTask: true);
      //   } else {
      //     HomeScreen().launch(context, isNewTask: true);
      //   }
      //   ToastConfig.showToast(message: response.message);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ttAppBar(context, "Add Video", showBack: false) as PreferredSizeWidget?,
      backgroundColor: black,
      body: SafeArea(
        child: Responsive(
          mobile: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(16),
            child: AutofillGroup(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(decoration: boxDecorationWithRoundedCorners(borderRadius: radius(16)), child: Image.asset(TT_ic_logo, height: 80).cornerRadiusWithClipRRect(16)),
                    16.height,
                    AppTextField(
                      controller: titleController,
                      textStyle: Config.textStyle,
                      textFieldType: TextFieldType.NAME,
                      decoration: Config.inputDecoration(labelText: "Title"),
                      nextFocus: titleFocus,
                      errorThisFieldRequired: errorThisFieldRequired,
                      errorInvalidEmail: "Title is invalid",
                      autoFillHints: [AutofillHints.name],
                    ),
                    16.height,
                    AppTextField(
                      controller: videoUrlController,
                      textStyle: Config.textStyle,
                      textFieldType: TextFieldType.NAME,
                      decoration: Config.inputDecoration(labelText: "Video URL"),
                      nextFocus: videoUrlFocus,
                      errorThisFieldRequired: errorThisFieldRequired,
                      errorInvalidEmail: "Short Video URL is invalid",
                      autoFillHints: [AutofillHints.name],
                    ),
                    16.height,
                    AppTextField(
                      controller: descController,
                      textStyle: Config.textStyle,
                      textFieldType: TextFieldType.NAME,
                      maxLines: 5,
                      minLines: 5,
                      decoration: Config.inputDecoration(labelText: "Description"),
                      nextFocus: descFocus,
                      errorThisFieldRequired: errorThisFieldRequired,
                      errorInvalidEmail: "Description is invalid",
                      autoFillHints: [AutofillHints.name],
                    ),
                    10.height,
                    Container(
                      width: double.infinity,
                      child: MaterialButton(
                          onPressed: () {
                            submit();
                            // TTOtpScreen().launch(context);
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          color: ColorsConfig.p_color,
                          child: Text('Add Video', style: primaryTextStyle(color: white))),
                    ),
                  ],
                ).center(),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
