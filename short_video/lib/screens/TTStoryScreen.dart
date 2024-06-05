import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/components/TTStoryComponent.dart';
import 'package:short_video/components/TTStoryHeaderComponent.dart';
import 'package:short_video/model/TTModel.dart';
import 'package:short_video/models/post.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTDataProvider.dart';

import '../utils/TTWidgets.dart';

class TTStoryScreen extends StatefulWidget {
  static String tag = '/TTStoryScreen';
  final List<Post> posts;
  const TTStoryScreen({super.key, required this.posts});

  @override
  TTStoryScreenState createState() => TTStoryScreenState();
}

class TTStoryScreenState extends State<TTStoryScreen> with SingleTickerProviderStateMixin {
  var mStoryList = getStoryData();


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
    // print("_currentPage ${_currentPage}");
    Widget _body() {
      return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.posts.length,
          itemBuilder: (context, index) {
            return TTStoryComponent(post: widget.posts[index]);
          });
    }

    return Scaffold(
      backgroundColor: TTBackgroundBlack,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _body(),
            // TTStoryHeaderComponent(),
            IconButton(
              onPressed: () {
                finish(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: white),
            ),
          ],
        ),
      ),
    );
  }
}
