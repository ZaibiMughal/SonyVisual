import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/business_logic/app_state.dart';
import 'package:short_video/business_logic/bloc/post_bloc.dart';
import 'package:short_video/config/colors_config.dart';
import 'package:short_video/model/TTModel.dart';
import 'package:short_video/screens/TTSearchInfoScreen.dart';
import 'package:short_video/screens/TTStoryScreen.dart';
import 'package:short_video/utils/TTDataProvider.dart';
import 'package:short_video/utils/TTImages.dart';
import 'package:short_video/utils/TTWidgets.dart';
import 'package:short_video/utils/utils.dart';

import '../business_logic/services/network_service_response.dart';
import '../config/main_config.dart';
import '../config/toast_config.dart';
import '../models/post.dart';
import '../models/screen_error.dart';
import 'TTErrorSection.dart';

class TTSearchScreen extends StatefulWidget {
  static String tag = '/TTSearchScreen';

  @override
  TTSearchScreenState createState() => TTSearchScreenState();
}

class TTSearchScreenState extends State<TTSearchScreen> {
  List<TTAccountModel> mAccountList = getAccount();

  List<TTSearchModel> mSearchList = getSearchData();
  var mSliderImages = [];
  var pageController = PageController();
  var selectedIndex = 0;

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
    // Loader().launch(context);
    response = await bloc.actionIndex();

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
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    //changeStatusColor(black);

    return SafeArea(
        child: Scaffold(
      // appBar:
      //     ttAppBar(context, "Home", showBack: false) as PreferredSizeWidget?,
      backgroundColor: black,
      body: Responsive(
        mobile: response != null && (posts.isEmpty)
            ? ErrorSection(
                screenError: ScreenError(
                    title: "sorry",
                    message: response != null ? response!.message : "",
                    icon: Icon(
                      Icons.error_outline,
                      size: 48,
                      color: ColorsConfig.p_color,
                    )))
            : Column(
                children: [
                  Container(
                          decoration: boxDecorationWithRoundedCorners(
                              borderRadius: radius(16)),
                          child: Image.asset(TT_ic_logo, height: 80)
                              .cornerRadiusWithClipRRect(16))
                      .center(),
                  16.height,
                  GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: posts.length,
                    // padding: EdgeInsets.only(bottom: 50),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Post post = Post(id: posts[index].id, title: posts[index].title, description: posts[index].description, url: posts[index].url, thumbnail: posts[index].thumbnail, userId: posts[index].userId, username: posts[index].username);
                          List<Post> temp = [];
                          temp.addAll(posts);

                          temp.removeAt(index);
                          temp.insert(0, post);
                          TTStoryScreen(posts: temp,).launch(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          child: GridTile(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: posts[index].thumbnail!,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(Icons.error),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.6,
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4),
                  ).expand(),
                ],
              ),
      ),
    ));
  }
}
