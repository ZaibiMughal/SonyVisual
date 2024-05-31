import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/utils/TTImages.dart';

import 'TTDashboardScreen.dart';

class TTLanguageSelection extends StatefulWidget {
  static String tag = '/TTLanguageSelection';

  @override
  TTLanguageSelectionState createState() => TTLanguageSelectionState();
}

class TTLanguageSelectionState extends State<TTLanguageSelection> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(seconds: 1));
    showDialog(
      context: context,
      builder: (BuildContext context) => LanguageDialog(),
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Image.asset(TT_icBackgroundLanguage, height: context.height(), fit: BoxFit.cover, width: context.width()));
  }
}

class LanguageDialog extends StatefulWidget {
  @override
  LanguageDialogState createState() => LanguageDialogState();
}

class LanguageDialogState extends State<LanguageDialog> {
  final List<String> mLanguageList = ["हिंदी", "English", "मराठी", "ਪੰਜਾਬੀ", "ગુજરાતી", "বাংলা", "اُردُو", "français"];
  bool? isChecked = false;

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
    return Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.deepOrangeAccent, width: 4), borderRadius: BorderRadius.all(Radius.circular(16.0))),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Choose Language", style: boldTextStyle()).center(),
                20.height,
                GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: mLanguageList.length,
                  padding: EdgeInsets.only(bottom: 50),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      decoration:
                          boxDecorationWithRoundedCorners(borderRadius: BorderRadius.circular(10), boxShadow: defaultBoxShadow(shadowColor: shadowColorGlobal), backgroundColor: Colors.grey.shade200, border: Border.all(color: Colors.white, width: 2)),
                      child: Text(
                        mLanguageList[index],
                        style: primaryTextStyle(),
                      ).center(),
                    ).onTap(() {
                      TTDashboardScreen().launch(context);
                    });
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 4, crossAxisSpacing: 16, childAspectRatio: 2.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value;
                        });
                      },
                    ),
                    Text(
                      "By continuing,I agree to Josh's \nTerms of Use and Privacy Policy",
                      style: secondaryTextStyle(),
                    ).expand(),
                  ],
                ),
              ],
            ).paddingAll(16),
          ),
        ));
  }
}
