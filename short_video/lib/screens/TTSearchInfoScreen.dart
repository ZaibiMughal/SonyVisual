import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/model/TTModel.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTDataProvider.dart';
import 'package:short_video/utils/TTImages.dart';
import 'package:short_video/utils/TTWidgets.dart';

import 'TTStoryScreen.dart';

class TTSearchInfoScreen extends StatefulWidget {
  static String tag = '/TTSearchInfoScreen';

  @override
  TTSearchInfoScreenState createState() => TTSearchInfoScreenState();
}

class TTSearchInfoScreenState extends State<TTSearchInfoScreen> {
  List<TTAccountModel> mAccountList = getAccount();

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
    Widget mOption(var value, var label) {
      return Column(
        children: [
          Text(value, style: boldTextStyle(size: 18, color: white)),
          4.height,
          Text(label, style: secondaryTextStyle(color: white)),
        ],
      );
    }

    return Scaffold(
      backgroundColor: black,
      appBar: ttAppBar(context, "#itelHaiToLifeMagical") as PreferredSizeWidget?,
      floatingActionButton: FloatingActionButton(
        backgroundColor: TTColorRed,
        child: Icon(Icons.videocam_rounded, color: white),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(TT_ic_banner1, height: 160, width: context.width(), fit: BoxFit.fill),
            20.height,
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.",
                    style: primaryTextStyle(color: white))
                .paddingOnly(left: 16, right: 16),
            20.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                mOption("100", "Following"),
                mOption("1K", "Fans"),
                mOption("50K", "Like"),
              ],
            ),
            20.height,
            GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: mAccountList.length,
              padding: EdgeInsets.only(bottom: 50),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                TTAccountModel mData = mAccountList[index];
                return Stack(
                  children: [
                    Container(
                      height: 200,
                      width: context.width(),
                      child: FittedBox(child: commonCacheImageWidget(mData.post), fit: BoxFit.fill),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8, left: 8, right: 16),
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [Icon(Icons.favorite_border, color: white, size: 16), 4.width, Text(mData.like, style: primaryTextStyle(color: white))],
                          ),
                          Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, color: black, border: Border.all(color: white, width: 1)),
                            child: CircleAvatar(radius: 10, backgroundColor: black, backgroundImage: AssetImage(mData.user)),
                          )
                        ],
                      ),
                    ),
                  ],
                ).onTap(() {
                  // TTStoryScreen().launch(context);
                });
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 2.0, crossAxisSpacing: 2.0, childAspectRatio: 1.2),
            )
          ],
        ),
      ),
    );
  }
}
