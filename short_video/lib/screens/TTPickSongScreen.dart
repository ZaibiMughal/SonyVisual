import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/model/TTModel.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTDataProvider.dart';
import 'package:short_video/utils/TTWidgets.dart';

class TTPickSongScreen extends StatefulWidget {
  static String tag = '/TTPickSongScreen';

  @override
  TTPickSongScreenState createState() => TTPickSongScreenState();
}

class TTPickSongScreenState extends State<TTPickSongScreen> {
  List<TTSongModel> mSongList = getSongData();
  var mValue = "";

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
      appBar: ttAppBar(context, "Pick a song") as PreferredSizeWidget?,
      body: Responsive(
        mobile: Column(
          children: [
            Container(
              height: 50,
              decoration: boxDecoration(bgColor: Colors.white10, radius: 10),
              child: Row(
                children: [
                  10.width,
                  Icon(Icons.search, color: white),
                  10.width,
                  Expanded(
                    child: TextFormField(
                      maxLines: 1,
                      style: primaryTextStyle(color: white),
                      decoration: InputDecoration(border: InputBorder.none, hintStyle: primaryTextStyle(color: white), labelStyle: primaryTextStyle(color: white), hintText: 'Search'),
                    ),
                  ),
                ],
              ),
            ),
            16.height,
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: mSongList.length,
              padding: EdgeInsets.only(bottom: 50),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var mData = mSongList[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      mValue = mData.name;
                      Navigator.of(context).pop(mValue);
                    });
                  },
                  child: Container(
                    color: mData.isSelected ? TTColorRed.withOpacity(0.2) : black,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(backgroundImage: AssetImage(mData.img), radius: 24),
                            10.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(mData.name, style: primaryTextStyle(color: white), maxLines: 2),
                                Text(mData.name, style: primaryTextStyle(color: Colors.white24)),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.play_circle_outline_rounded,
                          color: white,
                        )
                      ],
                    ).paddingOnly(left: 10, right: 10, top: 8, bottom: 8),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
