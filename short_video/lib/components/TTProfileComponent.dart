import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/model/TTModel.dart';
import 'package:short_video/screens/TTStoryScreen.dart';
import 'package:short_video/utils/TTDataProvider.dart';
import 'package:short_video/utils/TTWidgets.dart';

class TTProfileComponent extends StatefulWidget {
  static String tag = '/TTProfileComponent';

  @override
  TTProfileComponentState createState() => TTProfileComponentState();
}

class TTProfileComponentState extends State<TTProfileComponent> {
  List<TTAccountModel> mAccountList = getAccount();

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
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: mAccountList.length,
      padding: EdgeInsets.only(top: 10),
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
        childAspectRatio: 0.7,
          crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2
      ),
    );
  }
}
