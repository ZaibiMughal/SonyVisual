import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/model/TTModel.dart';
import 'package:short_video/screens/TTSearchInfoScreen.dart';
import 'package:short_video/screens/TTStoryScreen.dart';
import 'package:short_video/utils/TTDataProvider.dart';
import 'package:short_video/utils/TTImages.dart';
import 'package:short_video/utils/TTWidgets.dart';

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
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    pages = [
      Container(child: Image.asset(TT_ic_banner2, height: 90, fit: BoxFit.cover)),
      Container(child: Image.asset(TT_ic_banner1, height: 90, fit: BoxFit.cover)),
    ];
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
          appBar: ttAppBar(context, "Home", showBack: false) as PreferredSizeWidget?,
          backgroundColor: black,
          body: Responsive(
            mobile: Column(
              children: [
                16.height,
                GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: mAccountList.length,
                  // padding: EdgeInsets.only(bottom: 50),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        TTStoryScreen().launch(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                        child: GridTile(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: "https://picsum.photos/200/300",
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => const Center(
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
                      crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4
                  ),
                ).expand(),
              ],
            ),
          ),
        )
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        body: Responsive(
          mobile: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: context.width() - 80,
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
                  Icon(Icons.picture_in_picture_rounded, color: white)
                ],
              ).paddingAll(16),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: context.width(),
                      height: 150,
                      child: Stack(
                        children: [
                          PageView(
                            controller: pageController,
                            scrollDirection: Axis.horizontal,
                            children: pages,
                            onPageChanged: (index) {
                              selectedIndex = index;
                              setState(() {});
                            },
                          ),
                          AnimatedPositioned(
                            duration: Duration(seconds: 1),
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: DotIndicator(
                              pages: pages,
                              pageController: pageController,
                              indicatorColor: white,
                              onDotTap: (index) {
                                selectedIndex = index;
                                pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.linear);
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    8.height,
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: mSearchList.length,
                      padding: EdgeInsets.only(bottom: 50),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        mSearchList[index].imageList.forEach((element) {
                          mSliderImages.add(element);
                        });
                        print("Image" + mSearchList[index].view);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white10),
                                      child: Text("#", style: primaryTextStyle(size: 22, color: white)),
                                    ),
                                    8.width,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(mSearchList[index].message, style: boldTextStyle(color: white)),
                                        4.height,
                                        Text("Treading HashTag", style: primaryTextStyle(color: white)),
                                      ],
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    TTSearchInfoScreen().launch(context);
                                  },
                                  child: Container(
                                    decoration: boxDecoration(bgColor: Colors.white10),
                                    padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                    child: Text(mSearchList[index].view + " >", style: primaryTextStyle(color: white, size: 14)),
                                  ),
                                )
                              ],
                            ).paddingOnly(left: 10, right: 10),
                            16.height,
                            Container(
                              height: 140,
                              child: ListView.builder(
                                padding: EdgeInsets.only(left: 10),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: mSliderImages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      TTStoryScreen().launch(context);
                                    },
                                    child: Container(
                                      height: 140,
                                      width: 130,
                                      child: FittedBox(
                                        child: commonCacheImageWidget(mSliderImages[index]),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            8.height,
                            Divider(color: Colors.white10).paddingOnly(left: 10, right: 10),
                            8.height,
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ).expand()
            ],
          ),
        ),
      ),
    );
  }
}
