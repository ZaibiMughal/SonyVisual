import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:short_video/components/TTStoryComponent.dart';
import 'package:short_video/components/TTStoryHeaderComponent.dart';
import 'package:short_video/model/TTModel.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTDataProvider.dart';

class TTHomeScreen extends StatefulWidget {
  static String tag = '/TTHomeScreen';
  bool autoload;

  TTHomeScreen({super.key, this.autoload = false});

  @override
  TTHomeScreenState createState() => TTHomeScreenState();
}

class TTHomeScreenState extends State<TTHomeScreen> {
  var mStoryList = getStoryData();

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
    Widget _body() {
      return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 20,
          itemBuilder: (context, index) {
            TTStoryModel data = mStoryList[index % mStoryList.length];
            return TTStoryComponent(
              model: data,
              pos: index,
            );
          });
    }

    return Scaffold(
      backgroundColor: TTColorBlack,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _body(),
            TTStoryHeaderComponent(),
          ],
        ),
      ),
    );
  }
}
