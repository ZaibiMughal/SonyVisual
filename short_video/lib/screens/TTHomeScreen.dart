import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/components/TTStoryComponent.dart';
import 'package:short_video/components/TTStoryHeaderComponent.dart';
import 'package:short_video/config/toast_config.dart';
import 'package:short_video/model/TTModel.dart';
import 'package:short_video/models/post.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTDataProvider.dart';

import '../business_logic/bloc/post_bloc.dart';
import '../business_logic/services/network_service_response.dart';
import '../config/colors_config.dart';
import '../config/main_config.dart';
import '../models/screen_error.dart';
import 'TTErrorSection.dart';

class TTHomeScreen extends StatefulWidget {
  static String tag = '/TTHomeScreen';
  bool autoload;

  TTHomeScreen({super.key, this.autoload = false});

  @override
  TTHomeScreenState createState() => TTHomeScreenState();
}

class TTHomeScreenState extends State<TTHomeScreen> {
  var mStoryList = getStoryData();

  PostBloc bloc = PostBloc();

  NetworkServiceResponse? response;

  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
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
          :PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return TTStoryComponent(
              post: posts[index],
            );
          });
    }

    return Scaffold(
      backgroundColor: TTColorBlack,
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
