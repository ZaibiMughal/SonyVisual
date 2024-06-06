import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/business_logic/app_state.dart';
import 'package:short_video/config/colors_config.dart';
import 'package:short_video/config/main_config.dart';
import 'package:short_video/models/edit_profile.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTImages.dart';
import 'package:short_video/utils/TTWidgets.dart';

import '../business_logic/bloc/user_bloc.dart';
import '../business_logic/services/network_service_response.dart';
import '../config/toast_config.dart';

class TTEditProfileScreen extends StatefulWidget {
  static String tag = '/TTEditProfileScreen';

  @override
  TTEditProfileScreenState createState() => TTEditProfileScreenState();
}

class TTEditProfileScreenState extends State<TTEditProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  UserBloc userBloc = UserBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    firstNameController.text = AppCurrentState.instance.user!.firstName!;
    lastNameController.text = AppCurrentState.instance.user!.lastName!;
    emailController.text = AppCurrentState.instance.user!.email!;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> signUp() async {
    hideKeyboard(context);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Loader().launch(context);
      NetworkServiceResponse response =  await userBloc.actionEdit(EditProfile(firstName: firstNameController.text, lastName: lastNameController.text, email: emailController.text, userId: AppCurrentState.instance.getUserId()));
      Navigator.pop(context);
      if(response.status ==  Status.Error){
        ToastConfig.showToast(title: 'Error', message: response.message, context: context);
      } else {
        ToastConfig.showToast(title: 'Success', message: "Profile updated successfully!", context: context, alertType: AlertType.success);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ttAppBar(context, "Profile", actions: [
      ]) as PreferredSizeWidget?,
      backgroundColor: TTBackgroundBlack,
      body: Responsive(
        mobile: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.height,
                  Container(decoration: boxDecorationWithRoundedCorners(borderRadius: radius(16)), child: Image.asset(TT_ic_logo, height: 80).cornerRadiusWithClipRRect(16)).center(),
                  // CircleAvatar(backgroundImage: AssetImage(TT_ic_guest2), radius: 45).center(),
                  // 10.height,
                  // Text('Add Photo', style: boldTextStyle(color: ColorsConfig.p_color, size: 18)).center(),
                  16.height,
                  AppTextField(
                    controller: firstNameController,
                    textStyle: Config.textStyle,
                    textFieldType: TextFieldType.NAME,
                    decoration: Config.inputDecoration(labelText: "First Name"),
                    nextFocus: firstNameFocus,
                    errorThisFieldRequired: errorThisFieldRequired,
                    errorInvalidEmail: "First name is invalid",
                    autoFillHints: [AutofillHints.name],
                  ),
                  16.height,
                  AppTextField(
                    controller: lastNameController,
                    textStyle: Config.textStyle,
                    textFieldType: TextFieldType.NAME,
                    decoration: Config.inputDecoration(labelText: "Last Name"),
                    nextFocus: lastNameFocus,
                    errorThisFieldRequired: errorThisFieldRequired,
                    errorInvalidEmail: "Last Name is invalid",
                    autoFillHints: [AutofillHints.name],
                  ),
                  16.height,
                  AppTextField(
                    controller: emailController,
                    textStyle: Config.textStyle,
                    textFieldType: TextFieldType.EMAIL,
                    decoration: Config.inputDecoration(labelText: "Email"),
                    nextFocus: emailFocus,
                    errorThisFieldRequired: errorThisFieldRequired,
                    errorInvalidEmail: "Email is invalid",
                    autoFillHints: [AutofillHints.email],
                  ),
                  10.height,
                  Container(
                    width: double.infinity,
                    child: MaterialButton(
                        onPressed: () {
                          signUp();
                          // TTOtpScreen().launch(context);
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        color: ColorsConfig.btn_backgroundColor,
                        child: Text('Update')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
