import 'package:short_video/config/main_config.dart';

class API {
  API._();

  static const String baseUrl = Config.API_URL;
  static const String login = 'user/login/';
  static const String signup = 'user/create';
  static const String updateUserProfile = 'user/update';
  static const String changePassword = 'user/password/';
  static const String deleteUser = 'user/delete';
  static const String userProfile = 'user';
  static const String posts = 'video-post';
  static const String postsByUser = 'video-post';
  static const String createPost = 'video-post/create';
  static const String favoritePost = 'video-favorite/create';
  static const String updatePost = 'video-post/update';
  static const String deletePost = 'video-post/delete';
  static const String privacy = 'site/privacy-policy';
}
