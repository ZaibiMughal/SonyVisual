import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/config/colors_config.dart';
import 'package:short_video/config/main_config.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTImages.dart';
import 'package:short_video/utils/TTWidgets.dart';

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

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    firstNameController.text = "sss";
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> signUp() async {
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
      appBar: ttAppBar(context, "Profile", actions: [
      ]) as PreferredSizeWidget?,
      backgroundColor: black,
      body: Responsive(
        mobile: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                Container(decoration: boxDecorationWithRoundedCorners(borderRadius: radius(16)), child: Image.asset(TT_ic_logo, height: 80).cornerRadiusWithClipRRect(16)).center(),
                // CircleAvatar(backgroundImage: AssetImage(TT_ic_guest2), radius: 45).center(),
                10.height,
                Text('Add Photo', style: boldTextStyle(color: ColorsConfig.p_color, size: 18)).center(),
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
                      color: ColorsConfig.p_color,
                      child: Text('Update', style: primaryTextStyle(color: white))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
