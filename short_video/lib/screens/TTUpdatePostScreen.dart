import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:short_video/business_logic/app_state.dart';
import 'package:short_video/business_logic/bloc/post_bloc.dart';
import 'package:short_video/models/post.dart';
import 'package:short_video/screens/TTDashboardScreen.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTImages.dart';
import 'package:short_video/utils/TTStepProgressIndicator.dart';
import 'package:video_player/video_player.dart';

import '../../../main.dart';
import '../business_logic/services/network_service_response.dart';
import '../config/colors_config.dart';
import '../config/main_config.dart';
import '../config/toast_config.dart';
import '../utils/TTWidgets.dart';
import 'TTPickSongScreen.dart';

class TTUpdatePostScreen extends StatefulWidget {
  static String tag = '/TTUpdatePostScreen';
  final Post post;
  TTUpdatePostScreen({super.key, required this.post});

  @override
  TTUpdatePostScreenState createState() => TTUpdatePostScreenState();
}

class TTUpdatePostScreenState extends State<TTUpdatePostScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController videoUrlController = TextEditingController();
  TextEditingController descController = TextEditingController();

  FocusNode titleFocus = FocusNode();
  FocusNode videoUrlFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  FocusNode descFocus = FocusNode();


  PostBloc bloc = PostBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    titleController.text = widget.post.title!;
    descController.text = widget.post.description!;
    videoUrlController.text = widget.post.url!;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> submit() async {
    hideKeyboard(context);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Loader().launch(context);
      NetworkServiceResponse response =  await bloc.actionEdit(Post(id: widget.post.id, thumbnail: widget.post.thumbnail, title: titleController.text, description: descController.text, url: videoUrlController.text, userId: widget.post.userId));
      Navigator.pop(context);
      if(response.status ==  Status.Error){
        ToastConfig.showToast(title: 'Error', message: response.message, context: context);
      } else {
        ToastConfig.showToast(title: 'Success', message: "Video Edited Successfully", context: context, alertType: AlertType.success);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ttAppBar(context, "Update Video", showBack: true) as PreferredSizeWidget?,
      backgroundColor: TTBackgroundBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
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
                          textFieldType: TextFieldType.URL,
                          decoration: Config.inputDecoration(labelText: "Video URL"),
                          nextFocus: videoUrlFocus,
                          errorThisFieldRequired: errorThisFieldRequired,
                          errorInvalidURL: "Short Video URL is invalid",
                          autoFillHints: [AutofillHints.name],
                        ),
                        16.height,
                        AppTextField(
                          controller: descController,
                          textStyle: Config.textStyle,
                          textFieldType: TextFieldType.NAME,
                          focus: passFocus,
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
                              color: ColorsConfig.btn_backgroundColor,
                              child: Text('Update Video', style: primaryTextStyle(color: white))),
                        ),
                      ],
                    ).center(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
