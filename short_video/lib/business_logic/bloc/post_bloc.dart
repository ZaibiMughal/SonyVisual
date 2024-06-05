import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:short_video/models/edit_profile.dart';
import 'package:short_video/models/post.dart';
import 'package:short_video/models/user.dart';

import '../../config/main_config.dart';
import '../../models/change_password.dart';
import '../../models/login.dart';
import '../../models/signup.dart';
import '../apis.dart';
import '../app_state.dart';
import '../services/network_service_response.dart';
import '../services/rest_client.dart';

class PostBloc{
  final StreamController<Post> _controller = StreamController<Post>.broadcast();
  Sink<Post> get _inData => _controller.sink;
  Stream<Post> get outData => _controller.stream;

  void dispose() {
    _controller.close();
  }

  Future<NetworkServiceResponse<List<Post>>> actionIndex({int userId = 0}) async {

    NetworkServiceResponse result = await RestClient.instance.request(url: API.postsByUser, method: Config.HTTP_GET, params: {
      'user_id' : userId,
      'current_user_id': AppCurrentState.instance.getUserId()
    });

    List<Post> posts = [];

    if (result.status != Status.Error) {

      result.data['videoPosts'].forEach((element) {
        Post post = Post();
        post.fromJson(element);
        posts.add(post);
      });
    }
    return NetworkServiceResponse(
        data: posts,
        status: result.status,
        message: result.message);
  }

  Future<NetworkServiceResponse<User>> actionCreate(NewPost post) async {

    NetworkServiceResponse result = await RestClient.instance.request(url: API.createPost, method: Config.HTTP_GET, params: post.toMap());

    return NetworkServiceResponse(
        data: null,
        status: result.status,
        message: result.message);
  }

  Future<NetworkServiceResponse<void>> actionEdit(Post post) async {

    NetworkServiceResponse result = await RestClient.instance.request(url: API.updateUserProfile, method: Config.HTTP_GET, params: post.toMap());

    return NetworkServiceResponse(
        data: null,
        status: result.status,
        message: result.message);
  }

  Future<NetworkServiceResponse<void>> actionChangePassword(ChangePassword changePassword) async {

    Map<String, dynamic> payload = await changePassword.mapToArray();
    String url = '${API.changePassword}${AppCurrentState.instance.getUserId()}/${changePassword.password}/${changePassword.newPassword}/';
    NetworkServiceResponse result = await RestClient.instance.request(url: url, method: Config.HTTP_GET);

    if (result.status != Status.Error) {
      AppCurrentState.instance.user!.fromJson(result.data);
      AppCurrentState.instance.updateUser();
    }

    return NetworkServiceResponse(
        data: null,
        status: result.status,
        message: result.message);
  }


  Future<NetworkServiceResponse<User>> actionDelete(int id,int userId) async {

    NetworkServiceResponse result = await RestClient.instance.request(url: API.deletePost, method: Config.HTTP_GET, params: {
      "id" : id,
      "user_id" : userId,
    });

    return NetworkServiceResponse(
        data: null,
        status: result.status,
        message: result.message);
  }


  Future<NetworkServiceResponse<User>> actionUpdateFavoriteStatus(int userId, int videoId, int isFavorite) async {

    NetworkServiceResponse result = await RestClient.instance.request(url: API.favoritePost, method: Config.HTTP_GET, params: {
      "video_id" : videoId,
      "user_id" : userId,
      "is_favorite" : isFavorite,
    });

    return NetworkServiceResponse(
        data: null,
        status: result.status,
        message: result.message);
  }


}
