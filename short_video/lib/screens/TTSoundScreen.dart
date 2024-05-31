import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/model/TTModel.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTDataProvider.dart';
import 'package:short_video/utils/TTImages.dart';
import 'package:short_video/utils/TTWidgets.dart';

import 'TTStoryScreen.dart';

class TTSoundScreen extends StatefulWidget {
  static String tag = '/TTSoundScreen';

  @override
  TTSoundScreenState createState() => TTSoundScreenState();
}

class TTSoundScreenState extends State<TTSoundScreen> {
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
    return Scaffold(
      backgroundColor: black,
      appBar: ttAppBar(context, "", actions: [
        Transform(alignment: Alignment.center, transform: Matrix4.rotationY(math.pi), child: Icon(Icons.reply, size: 35, color: white)).onTap(() {
          toast("Share");
        }),
      ]) as PreferredSizeWidget?,
      floatingActionButton: FloatingActionButton(
        backgroundColor: TTColorRed,
        child: Icon(Icons.videocam_rounded, color: white),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(TT_ic_user),
                radius: 20,
              ),
              10.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Original sound by(@lee)", style: primaryTextStyle(color: white)),
                  Text("@lee", style: primaryTextStyle(color: white)),
                  Text("Uploaded by: @lee", style: secondaryTextStyle(color: white)),
                ],
              )
            ],
          ).paddingOnly(left: 16, right: 16, bottom: 16),
          Divider().paddingOnly(left: 16, right: 16),
          16.height,
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
                TTStoryScreen().launch(context);
              });
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 2.0, crossAxisSpacing: 2.0, childAspectRatio: 1.2),
          )
        ],
      )),
    );
  }
}
