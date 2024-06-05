import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:short_video/components/TTStoryComponent.dart';
import 'package:short_video/components/TTStoryHeaderComponent.dart';
import 'package:short_video/config/toast_config.dart';
import 'package:short_video/model/TTModel.dart';
import 'package:short_video/models/post.dart';
import 'package:short_video/providers/ad_provider.dart';
import 'package:short_video/providers/timer_provider.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTDataProvider.dart';
import 'package:short_video/utils/utils.dart';

import '../business_logic/bloc/post_bloc.dart';
import '../business_logic/services/network_service_response.dart';
import '../config/colors_config.dart';
import '../config/main_config.dart';
import '../models/screen_error.dart';
import 'TTErrorSection.dart';

class TTHomeLoopScreen extends StatefulWidget {
  static String tag = '/TTHomeLoopScreen';
  bool autoload;

  TTHomeLoopScreen({super.key, this.autoload = false});

  @override
  TTHomeLoopScreenState createState() => TTHomeLoopScreenState();
}

class TTHomeLoopScreenState extends State<TTHomeLoopScreen> {
  var mStoryList = getStoryData();

  PostBloc bloc = PostBloc();

  NetworkServiceResponse? response;

  List<Post> posts = [];

  late PageController _pageController;
  int _currentPage = 0;

  DateTime? _lastCallTime;

  bool isAdLoadedresult = false;

  AdProvider? adProvider;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {

    _pageController = PageController(initialPage: 0);


    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(widget.autoload != true){
        bool result = await Utils.showInterstitialAd();
        adProvider = Provider.of<AdProvider>(context, listen: false);
        adProvider?.setIsAdLoaded(result);
      }
    });


    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Loader().launch(context);
    });
    response = await bloc.actionIndex();

    if (response!.status == Status.Error) {
      ToastConfig.showToast(
          title: 'Error', message: response!.message, context: context);
    } else {
      posts.addAll(response!.data);
    }

    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      finish(context);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  void _goToNextPage(TimerProvider provider) async {

    DateTime now = DateTime.now();

    if (_lastCallTime == null || now.difference(_lastCallTime!).inSeconds > 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        provider.setIsVideoFinished(false);
      });

      // print("My Next Video is: ${_currentPage}");


      if (widget.autoload && (_currentPage < posts.length - 1)) {
        _pageController.animateToPage(
          _currentPage + 1,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
      _lastCallTime = now;
    }

  }



  @override
  Widget build(BuildContext context) {
    Widget _body() {
      return response != null && (posts.isEmpty)
          ? ErrorSection(
          screenError: ScreenError(
              title: "sorry",
              message: response != null ? response!.message : "",
              icon: Icon(
                Icons.error_outline,
                size: 48,
                color: ColorsConfig.p_color,
              )))
          :Consumer<TimerProvider>(
        builder: (context, provider, child) {
          if(provider.getIsVideoFinished()){
            _goToNextPage(provider);
          }
          return PageView.builder(
            controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                _currentPage = index;
                return TTStoryComponent(
                  post: posts[index],
                );
              });
        }
          );
    }

    return Scaffold(
      backgroundColor: TTBackgroundBlack,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _body(),
            // TTStoryHeaderComponent(),
          ],
        ),
      ),
    );
  }
}
