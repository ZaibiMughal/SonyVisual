import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/components/TTProfileComponent.dart';
import 'package:short_video/screens/TTEditProfileScreen.dart';
import 'package:short_video/screens/TTFollowingListScreen.dart';
import 'package:short_video/screens/TTSettingScreen.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTImages.dart';
import 'package:short_video/utils/TTWidgets.dart';

import 'TTFanListScreen.dart';

class TTProfileScreen extends StatefulWidget {
  static String tag = '/TTProfileScreen';
  bool? isUser;

  TTProfileScreen({bool? isUser}) {
    this.isUser = isUser;
  }

  @override
  TTProfileScreenState createState() => TTProfileScreenState();
}

class TTProfileScreenState extends State<TTProfileScreen> {
  var isSelected = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    //changeStatusColor(black);

    Widget mOption(var value, var label) {
      return Column(
        children: [
          Text(value, style: boldTextStyle(size: 18, color: white)),
          4.height,
          Text(label, style: secondaryTextStyle(color: white)),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: ttAppBar(context, "Profile", showBack: false, actions: [
          PopupMenuButton(
            color: Colors.grey.shade200,
            icon: Icon(
              Icons.more_horiz,
              color: white,
            ),
            onSelected: (dynamic value) {
              if (value == "setting") {
                TTSettingScreen().launch(context);
              } else {
                TTEditProfileScreen().launch(context);
              }
            },
            itemBuilder: (context) {
              List<PopupMenuEntry<Object>> list = [];
              list.add(PopupMenuItem(child: Text("Settings", style: primaryTextStyle()), value: 'setting'));
              list.add(PopupMenuItem(child: Text("Edit Profile", style: primaryTextStyle()), value: 'profile'));
              return list;
            },
          )
        ]) as PreferredSizeWidget?,
        body: Responsive(
            mobile: DefaultTabController(
          length: 1,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 250.0,
                  floating: true,
                  backgroundColor: black,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    indicatorColor: Colors.blueAccent,
                    // tabs: [Tab(icon: Icon(Icons.grid_on, color: white)), Tab(icon: Icon(Icons.favorite_border, color: white))],
                    tabs: [Tab(icon: Icon(Icons.grid_on, color: white))],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Container(
                      child: Column(
                        children: <Widget>[
                          8.height,
                          Container(decoration: boxDecorationWithRoundedCorners(borderRadius: radius(16)), child: Image.asset(TT_ic_logo, height: 80).cornerRadiusWithClipRRect(16)),
                          10.height,
                          Text("SonyVisual", style: boldTextStyle(size: 18, color: white)),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              // children: [TTProfileComponent(), TTProfileComponent()],
              children: [TTProfileComponent()],
            ),
          ),
        )),
      ),
    );
  }
}
