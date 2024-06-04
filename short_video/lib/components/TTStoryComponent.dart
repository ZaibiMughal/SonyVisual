import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:short_video/business_logic/app_state.dart';
import 'package:short_video/model/TTModel.dart';
import 'package:short_video/models/post.dart';
import 'package:short_video/providers/ad_provider.dart';
import 'package:short_video/providers/timer_provider.dart';
import 'package:short_video/screens/TTProfileScreen.dart';
import 'package:short_video/screens/TTSoundScreen.dart';
import 'package:short_video/screens/home.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTWidgets.dart';
import 'package:short_video/utils/utils.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import'dart:io' show Platform;

class TTStoryComponent extends StatefulWidget {
  static String tag = '/TTStoryComponent';

  @override
  TTStoryComponentState createState() => TTStoryComponentState();

  // TTStoryModel? model;
  final Post post;

  TTStoryComponent({super.key, required this.post});
}

class TTStoryComponentState extends State<TTStoryComponent> with SingleTickerProviderStateMixin {
  bool play = true;
  // late VideoPlayerController _controller;

  late YoutubePlayerController _controller;



  late AnimationController animationController;
  PageController pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  PageController mController = new PageController();

  bool _isPlayerReady = false;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  late TimerProvider timerProvider;
  AdProvider? adProvider;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: Utils.getIdFromUrl(widget.post.url!),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
          hideControls: true,
      ),
    );


    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;

    init();
  }




  void listener() async {
    if (_controller.value.isPlaying && mounted && !_controller.value.isFullScreen) {
      // print("Duration: ${_controller.value.position} - ${_controller.value.metaData.duration} - ${(_controller.value.metaData.duration - _controller.value.position)}");
      if((_controller.value.metaData.duration - _controller.value.position) < const Duration(seconds: 2) && _controller.value.position != Duration.zero){

        timerProvider.setIsVideoFinished(true);
        // _controller.pause();
        // await Future.delayed(Duration(seconds: 2));
        _controller.seekTo(Duration(seconds: 0));
      }
    }
  }

  init() async {
    animationController = new AnimationController(vsync: this, duration: new Duration(seconds: 5));
    animationController.repeat();
  }


  @override
  void dispose() {
    _controller.dispose();
    animationController.dispose();
    adProvider!.setIsAdLoaded(false);

    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    timerProvider = Provider.of<TimerProvider>(context, listen: false);
    adProvider = Provider.of<AdProvider>(context, listen: false);
    Widget _bottomContent() {
      return Container(
        alignment: Alignment.topLeft,
        width: context.width() - 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text("By: ${widget.post!.username}",
                style: primaryTextStyle(color: white)),
            8.height,
            Text(widget.post!.description!.substring(0,
                widget.post.description!.length > 15 ? 15 : widget.post
                    .description!.length),
                style: primaryTextStyle(color: white)),
            // 8.height,
            // Container(
            //   width: context.width() - 60,
            //   child: Row(
            //     children: <Widget>[
            //       Icon(Icons.music_note, color: white),
            //       Container(
            //         height: 20,
            //         width: 80,
            //         child: Marquee(
            //           textDirection: TextDirection.ltr,
            //           child: Text('Original Sound' + " " + widget.model!.sound, style: primaryTextStyle(color: white)),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ).paddingOnly(left: 16, bottom: 16),
      );
    }

    Widget _rightContent() {
      return Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // GestureDetector(
            //   onTap: () {
            //     if (_controller.value.isPlaying) _controller.pause();
            //     TTProfileScreen(isUser: false).launch(context);
            //   },
            //   child: Container(
            //     width: 45,
            //     height: 50,
            //     child: Stack(
            //       children: <Widget>[
            //         // Container(
            //         //   decoration: BoxDecoration(shape: BoxShape.circle, color: black, border: Border.all(color: white, width: 1)),
            //         //   child: CircleAvatar(radius: 20, backgroundColor: black, backgroundImage: AssetImage(widget.model!.profile)),
            //         // ),
            //         Align(
            //           alignment: Alignment.bottomCenter,
            //           child: Container(width: 20, height: 20, decoration: BoxDecoration(shape: BoxShape.circle, color: TTColorRed, border: Border.all(color: TTColorRed, width: 1)), child: Center(child: Icon(Icons.add, size: 16, color: white))),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            16.height,
            IconButton(
                icon: Icon(Icons.shopping_bag_outlined, size: 28, color: white),
                onPressed: () async {
                  String url = Platform.isAndroid ? "https://play.google.com/store/apps/details?id=com.Clorop.Llc" : "https://apps.apple.com/us/app/clorop-earn-money/id6499473697";
                  await Utils.launchExternalUrl(Uri.parse(url));
                }),
            IconButton(
                icon: Icon(Icons.radio_outlined, size: 25, color: white),
                onPressed: () async {
                  String url = Platform.isAndroid ? "https://play.google.com/store/apps/details?id=com.sonyplays.app" : "https://apps.apple.com/us/app/sony-plays/id6502907038";
                  await Utils.launchExternalUrl(Uri.parse(url));
                }),
            IconButton(
                icon: Icon(Icons.chat_bubble_outline, size: 25, color: white),
                onPressed: () async {
                  if (_controller.value.isPlaying) _controller.pause();
                  MyHomePage().launch(context);
                  // String url = Platform.isAndroid ? "https://play.google.com/store/apps/details?id=com.sonyplays.app" : "https://apps.apple.com/us/app/sony-plays/id6502907038";
                  // await Utils.launchExternalUrl(Uri.parse(url));
                }),
            // Text(widget.model!.like, style: primaryTextStyle(color: white)),
            10.height,
            // Transform(alignment: Alignment.center, transform: Matrix4.rotationY(math.pi), child: Icon(Icons.reply, size: 35, color: white)).onTap(() {
            //   setState(() {
            //     onShareTap(context);
            //   });
            // }),
            // Text(widget.model!.share, style: primaryTextStyle(color: white)),
            // 10.height,
            AnimatedBuilder(
              animation: animationController,
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: black),
                width: 45,
                height: 45,
                padding: EdgeInsets.all(8),
                child: CircleAvatar(radius: 16, backgroundImage: NetworkImage("https://admin.sonyvisual.com/images/logo.png")),
              ).onTap(() {
                if (_controller.value.isPlaying) _controller.pause();
                TTProfileScreen(userId: widget.post.userId,).launch(context);

                // TTSoundScreen().launch(context);
              }),
              builder: (context, _widget) {
                return Transform.rotate(angle: animationController.value * 6.3, child: _widget);
              },
            )
          ],
        ).paddingOnly(right: 10, bottom: 10),
      );
    }

    Widget mBody() {
      return Consumer<AdProvider>(
          builder: (context, provider, child)
      {
        return Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  setState(() {
                    if (play) {
                      _controller.pause();
                      play = !play;
                    } else {
                      _controller.play();
                      play = !play;
                    }
                  });
                },
                child: Container(
                  width: context.width(),
                  height: context.height(),
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.amber,
                    progressColors: const ProgressBarColors(
                      playedColor: Colors.amber,
                      handleColor: Colors.amberAccent,
                    ),
                    onReady: () {
                      if (provider.getIsAdLoaded()) {
                        _controller.pause();
                      }
                      _controller.addListener(listener);
                    },
                  ),

                  // VideoPlayer(_controller),
                )

            ),
            _rightContent(),
            _bottomContent(),
          ],
        );
      });
    }

    return mBody();
  }
}
