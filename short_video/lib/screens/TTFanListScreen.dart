import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTDataProvider.dart';
import 'package:short_video/utils/TTWidgets.dart';

class TTFanListScreen extends StatefulWidget {
  static String tag = '/TTFanListScreen';

  @override
  TTFanListScreenState createState() => TTFanListScreenState();
}

class TTFanListScreenState extends State<TTFanListScreen> {
  var mFollowingList = getFanData();

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
      backgroundColor: TTBackgroundBlack,
      appBar: ttAppBar(context, "Top Fans") as PreferredSizeWidget?,
      body: Responsive(
        mobile: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: mFollowingList.length,
            padding: EdgeInsets.only(bottom: 50),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var mData = mFollowingList[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(backgroundImage: AssetImage(mData.userImg), radius: 24),
                      10.width,
                      Text(mData.name, style: primaryTextStyle(color: white), maxLines: 2),
                    ],
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                    ),
                    onPressed: () {
                      setState(() {
                        mData.isSelected = !mData.isSelected;
                      });
                    },
                    child: Container(
                        decoration: boxDecorationWithRoundedCorners(borderRadius: BorderRadius.circular(4), backgroundColor: mData.isSelected ? Colors.grey : TTColorRed),
                        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                        child: Text(mData.isSelected ? 'Following' : 'Follow', style: primaryTextStyle(color: white, size: 14))),
                  ),
                ],
              ).paddingOnly(left: 10, right: 10, top: 16);
            }),
      ),
    );
  }
}
