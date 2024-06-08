import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/business_logic/app_state.dart';
import 'package:short_video/components/TTProfileComponent.dart';
import 'package:short_video/screens/TTEditProfileScreen.dart';
import 'package:short_video/screens/TTFollowingListScreen.dart';
import 'package:short_video/screens/TTSettingScreen.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTImages.dart';
import 'package:short_video/utils/TTWidgets.dart';

import '../business_logic/bloc/post_bloc.dart';
import '../business_logic/services/network_service_response.dart';
import '../config/colors_config.dart';
import '../config/main_config.dart';
import '../config/toast_config.dart';
import '../main.dart';
import '../models/post.dart';
import '../models/screen_error.dart';
import '../storage/shared_storage.dart';
import '../utils/utils.dart';
import 'TTErrorSection.dart';
import 'TTFanListScreen.dart';

class TTProfileScreen extends StatefulWidget {
  static String tag = '/TTProfileScreen';

  int? userId;
  TTProfileScreen({super.key, this.userId});
  @override
  TTProfileScreenState createState() => TTProfileScreenState();
}

class TTProfileScreenState extends State<TTProfileScreen> with RouteAware{
  var isSelected = false;
  PostBloc bloc = PostBloc();
  NetworkServiceResponse? response;

  List<Post> posts = [];

  @override
  void initState() {
    super.initState();

    Utils.showInterstitialAd();

    init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      // Subscribe to the RouteObserver only if the modalRoute is a PageRoute
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void dispose() {
    // Unsubscribe from the RouteObserver
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Perform setState or any other necessary updates
    setState(() {
      // Update your state here
    });
    super.didPopNext();

  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Loader().launch(context);
    });
    // Loader().launch(context);
    response = await bloc.actionIndex(userId: widget.userId ?? AppCurrentState.instance.getUserId());

    if (response!.status == Status.Error) {
      ToastConfig.showToast(
          title: 'Error', message: response!.message, context: context);
    } else {
      posts.addAll(response!.data);
      setState(() {});
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      finish(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mOption(var value, var label) {
      return Column(
        children: [
          Text(value, style: boldTextStyle(size: 18, color: white)),
          4.height,
          Text(label, style: secondaryTextStyle(color: white)),
        ],
      );
    }

    return Scaffold(
      backgroundColor: TTBackgroundBlack,
      appBar: ttAppBar(context, "Profile", showBack: widget.userId != null, actions: [
        AppCurrentState.instance.getIsLoggedIn() == true  ? PopupMenuButton(
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
        ): SizedBox()
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
                backgroundColor: TTBackgroundBlack,
                pinned: true,
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  indicatorColor: ColorsConfig.p_color,
                  // tabs: [Tab(icon: Icon(Icons.grid_on, color: white)), Tab(icon: Icon(Icons.favorite_border, color: white))],
                  tabs: [Tab(icon: Icon(Icons.grid_on, color: white))],
                ),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    child: Column(
                      children: <Widget>[
                        8.height,
                        Container(
                          width: 80,
                            decoration: boxDecorationWithRoundedCorners(borderRadius: radius(16)), child: commonCacheImageWidget(AppCurrentState.instance.user!.thumbnail, height: 80).cornerRadiusWithClipRRect(16).center()),
                        10.height,
                        Text(widget.userId != null ? posts.isNotEmpty ? posts[0].username! : "SonyVisual" : AppCurrentState.instance.getUser() != null ?AppCurrentState.instance.getUser()!.getFullName() : "SonyVisual", style: boldTextStyle(size: 18, color: white)),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: response != null && (posts.isEmpty)
              ? ErrorSection(
              screenError: ScreenError(
                  title: "sorry",
                  message: response != null ? response!.message : "",
                  icon: Icon(
                    Icons.error_outline,
                    size: 48,
                    color: ColorsConfig.p_color,
                  )))
              : TabBarView(
            // children: [TTProfileComponent(), TTProfileComponent()],
            children: [TTProfileComponent(
              posts: posts,
            )],
          ),
        ),
      )),
    );
  }
}
