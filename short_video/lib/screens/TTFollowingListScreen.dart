import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTDataProvider.dart';
import 'package:short_video/utils/TTWidgets.dart';

class TTFollowingListScreen extends StatefulWidget {
  static String tag = '/TTFollowingListScreen';

  @override
  TTFollowingListScreenState createState() => TTFollowingListScreenState();
}

class TTFollowingListScreenState extends State<TTFollowingListScreen> {
  var mFollowingList = getFollowingData();

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
      appBar: ttAppBar(context, "Following") as PreferredSizeWidget?,
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
                    onPressed: () {
                      setState(() {
                        mData.isSelected = !mData.isSelected;
                      });
                    },
                    child: Container(
                        decoration: boxDecorationWithRoundedCorners(borderRadius: BorderRadius.circular(4), backgroundColor: mData.isSelected ? TTColorRed : Colors.grey),
                        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                        child: Text(mData.isSelected ? 'Follow' : 'Following', style: primaryTextStyle(color: white, size: 14))),
                  ),
                ],
              ).paddingOnly(left: 10, right: 10, top: 16);
            }),
      ),
    );
  }
}
