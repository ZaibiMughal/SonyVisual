import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/business_logic/app_state.dart';
import 'package:short_video/model/TTModel.dart';
import 'package:short_video/screens/TTAddPostScreen.dart';
import 'package:short_video/screens/TTStoryScreen.dart';
import 'package:short_video/screens/TTUpdatePostScreen.dart';
import 'package:short_video/utils/TTDataProvider.dart';
import 'package:short_video/utils/TTWidgets.dart';

import '../business_logic/bloc/post_bloc.dart';
import '../business_logic/services/network_service_response.dart';
import '../config/main_config.dart';
import '../config/toast_config.dart';
import '../models/post.dart';

class TTProfileComponent extends StatefulWidget {
  static String tag = '/TTProfileComponent';
  final List<Post> posts;

  const TTProfileComponent({super.key, required this.posts});
  @override
  TTProfileComponentState createState() => TTProfileComponentState();
}

class TTProfileComponentState extends State<TTProfileComponent> {
  List<TTAccountModel> mAccountList = getAccount();

  PostBloc bloc = PostBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }


  Future<bool> delete(int id) async {
    hideKeyboard(context);
    Loader().launch(context);
    NetworkServiceResponse response =  await bloc.actionDelete(id, AppCurrentState.instance.getUserId());
    Navigator.pop(context);
    if(response.status ==  Status.Error){
      ToastConfig.showToast(title: 'Error', message: response.message, context: context);
      return false;
    } else {
      ToastConfig.showToast(title: 'Success', message: "Video Deleted Successfully", context: context, alertType: AlertType.success);
      return true;
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.posts.length,
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            SizedBox(
              height: 200,
              child: GestureDetector(
                onTap: () {

                  Post post = Post(id: widget.posts[index].id, title: widget.posts[index].title, description: widget.posts[index].description, url: widget.posts[index].url, thumbnail: widget.posts[index].thumbnail, userId: widget.posts[index].userId, username: widget.posts[index].username, isFavorite: widget.posts[index].isFavorite);
                  List<Post> temp = [];
                  temp.addAll(widget.posts);

                  temp.removeAt(index);
                  temp.insert(0, post);

                  TTStoryScreen(posts: temp,).launch(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: GridTile(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: widget.posts[index].thumbnail!,
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
              ),
            ),
             widget.posts[index].userId == AppCurrentState.instance.getUserId() ? Positioned(
              top: 0,
                right: -10,
                child: PopupMenuButton(
                  color: Colors.grey.shade200,
                  icon: Icon(
                    Icons.more_vert,
                    color: white,
                  ),
                  onSelected: (dynamic value) async {
                    if (value == "edit") {
                      TTUpdatePostScreen(post: widget.posts[index],).launch(context);
                    } else {
                      bool? res = await showConfirmDialog(context, 'Are you sure, you want to delete?');
                      if (res ?? false) {
                        bool result = await delete(widget.posts[index].id!);
                        if(result){
                          widget.posts.removeAt(index);
                          setState(() { });
                        }
                        // AppState.instance.logout();
                        // TTSignINScreen().launch(context, isNewTask: true);
                      }
                    }
                  },
                  itemBuilder: (context) {
                    List<PopupMenuEntry<Object>> list = [];
                    list.add(PopupMenuItem(child: Text("Edit", style: primaryTextStyle()), value: 'edit'));
                    list.add(PopupMenuItem(child: Text("Delete", style: primaryTextStyle()), value: 'delete'));
                    return list;
                  },
                )
            ) : SizedBox()
          ],
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.7,
          crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2
      ),
    );
  }
}
