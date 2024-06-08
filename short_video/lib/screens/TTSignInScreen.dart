import 'package:country_code_picker/country_code_picker.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/business_logic/bloc/user_bloc.dart';
import 'package:short_video/config/colors_config.dart';
import 'package:short_video/config/toast_config.dart';
import 'package:short_video/models/user.dart';
import 'package:short_video/screens/TTDashboardScreen.dart';
import 'package:short_video/screens/TTOTPScreen.dart';
import 'package:short_video/screens/TTSignUpScreen.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTImages.dart';

import '../business_logic/services/network_service_response.dart';
import '../config/main_config.dart';
import '../models/login.dart';
import '../storage/shared_storage.dart';
import '../utils/TTWidgets.dart';

class TTSignINScreen extends StatefulWidget {
  static String tag = '/TTSignINScreen';
  bool? goBack;
  TTSignINScreen({super.key, this.goBack = false});

  @override
  TTSignINScreenState createState() => TTSignINScreenState();
}

class TTSignINScreenState extends State<TTSignINScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserBloc userBloc = UserBloc();

  FocusNode passFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  bool passwordVisible = false;

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

  Future<void> signIn() async {



    hideKeyboard(context);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Loader().launch(context);
      NetworkServiceResponse response =  await userBloc.actionLogin(Login(email: emailController.text, password: passwordController.text));
      Navigator.pop(context);
      if(response.status ==  Status.Error){
        ToastConfig.showToast(title: 'Error', message: response.message, context: context);
      } else {
        if(widget.goBack == true){
          finish(context);
        } else {
          TTDashboardScreen().launch(context, isNewTask: true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TTBackgroundBlack,
      appBar: ttAppBar(context, "", showBack: widget.goBack!) as PreferredSizeWidget?,
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
                    Text("Login", style: boldTextStyle(size: 28, color: Colors.white), textAlign: TextAlign.center),
                    // Image.asset(TT_ic_logo, height: context.height() * 0.2, fit: BoxFit.fitWidth, width: context.width() * 0.2),
                    // Text('Enter your mobile number', style: boldTextStyle(color: white, size: 18)),
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
                      suffixIconColor: ColorsConfig.btn_textColor,
                      textStyle: Config.textStyle,
                      textFieldType: TextFieldType.PASSWORD,
                      focus: passFocus,
                      errorThisFieldRequired: errorThisFieldRequired,
                      decoration: Config.inputDecoration(labelText: "Password"),
                      autoFillHints: [AutofillHints.password],
                      onFieldSubmitted: (s) {
                        signIn();
                      },
                    ),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Not a member?", style: primaryTextStyle().copyWith(color: ColorsConfig.p_textColor)),
                        GestureDetector(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 18.0, color: ColorsConfig.p_textColor),
                            ).paddingLeft(4),
                            onTap: () {
                              TTSignUpScreen().launch(context);
                            })
                      ],
                    ),
                    10.height,
                    Container(
                      width: double.infinity,
                      child: MaterialButton(
                          onPressed: () {
                            signIn();
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          color: ColorsConfig.btn_backgroundColor,
                          child: Text('Sign In')),
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
    );
  }
}
