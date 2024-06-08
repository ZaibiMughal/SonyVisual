import 'dart:io';

import 'package:camera/camera.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/business_logic/services/network_service_response.dart';
import 'package:short_video/config/colors_config.dart';
import 'package:short_video/models/signup.dart';
import 'package:short_video/screens/TTOTPScreen.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTImages.dart';
import 'package:short_video/utils/utils.dart';

import '../business_logic/bloc/user_bloc.dart';
import '../config/main_config.dart';
import '../config/toast_config.dart';
import '../utils/TTWidgets.dart';
import 'TTDashboardScreen.dart';

class TTSignUpScreen extends StatefulWidget {
  static String tag = '/TTSignUpScreen';

  @override
  TTSignUpScreenState createState() => TTSignUpScreenState();
}

class TTSignUpScreenState extends State<TTSignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  bool passwordVisible = false;

  UserBloc userBloc = UserBloc();
  File? pickedImage;


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


  Future<void> signUp() async {
    hideKeyboard(context);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Loader().launch(context);
      NetworkServiceResponse response =  await userBloc.actionSignUp(SignUp(firstName: firstNameController.text, lastName: lastNameController.text, email: emailController.text, password: passwordController.text, image: pickedImage));
      Navigator.pop(context);
      if(response.status ==  Status.Error){
        ToastConfig.showToast(title: 'Error', message: response.message, context: context);
      } else {
        TTDashboardScreen().launch(context, isNewTask: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('', showBack: true, textColor: Colors.white, color: Colors.transparent, systemUiOverlayStyle: SystemUiOverlayStyle.light,elevation: 0),

      backgroundColor: TTBackgroundBlack,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      GestureDetector(
                        onTap: () async {
                          pickedImage = await Utils.pickImg();
                          setState(() {});
                        },
                        child: Container(
                            decoration: boxDecorationWithRoundedCorners(borderRadius: radius(16)), child: commonCacheImageWidget(TT_ic_logo, file: pickedImage, height: 80).cornerRadiusWithClipRRect(16),
                        ),
                      ),
                      16.height,
                      Text("Sign Up", style: boldTextStyle(size: 28, color: Colors.white), textAlign: TextAlign.center),
                      // Image.asset(TT_ic_logo, height: context.height() * 0.2, fit: BoxFit.fitWidth, width: context.width() * 0.2),
                      // Text('Enter your mobile number', style: boldTextStyle(color: white, size: 18)),
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
                      16.height,
                      AppTextField(
                        controller: passwordController,
                        textStyle: Config.textStyle,
                        textFieldType: TextFieldType.PASSWORD,
                        focus: passFocus,
                        errorThisFieldRequired: errorThisFieldRequired,
                        decoration: Config.inputDecoration(labelText: "Password"),
                        autoFillHints: [AutofillHints.password],
                        onFieldSubmitted: (s) {
                          signUp();
                        },
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
                            child: Text('Sign Up')),
                      ),

                      // Container(
                      //     decoration: boxDecorationWithRoundedCorners(borderRadius: BorderRadius.circular(4), backgroundColor: TTBackgroundBlack, border: Border.all(color: Colors.white24, width: 1)),
                      //     padding: EdgeInsets.all(0),
                      //     margin: EdgeInsets.all(16),
                      //     child: Row(
                      //       children: <Widget>[
                      //         CountryCodePicker(onChanged: print, padding: EdgeInsets.all(0), textStyle: primaryTextStyle(color: white)),
                      //         Container(height: 30.0, width: 1.0, color: Colors.white24, margin: const EdgeInsets.only(left: 10.0, right: 10.0)),
                      //         Expanded(
                      //           child: TextFormField(
                      //             keyboardType: TextInputType.number,
                      //             maxLength: 10,
                      //             style: primaryTextStyle(),
                      //             decoration: InputDecoration(
                      //                 counterText: "", contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0), hintText: "Mobile number", hintStyle: primaryTextStyle(color: white), labelStyle: primaryTextStyle(color: white), border: InputBorder.none),
                      //           ),
                      //         )
                      //       ],
                      //     )),
                    ],
                  ).center(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
