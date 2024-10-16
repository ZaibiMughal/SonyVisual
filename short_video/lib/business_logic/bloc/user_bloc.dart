import 'dart:async';

import 'package:short_video/models/edit_profile.dart';
import 'package:short_video/models/user.dart';

import '../../config/main_config.dart';
import '../../models/change_password.dart';
import '../../models/login.dart';
import '../../models/signup.dart';
import '../apis.dart';
import '../app_state.dart';
import '../services/network_service_response.dart';
import '../services/rest_client.dart';

class UserBloc{
  final StreamController<User> _controller = StreamController<User>.broadcast();
  Sink<User> get _inData => _controller.sink;
  Stream<User> get outData => _controller.stream;

  void dispose() {
    _controller.close();
  }

  Future<NetworkServiceResponse<User>> actionLogin(Login login) async {

    NetworkServiceResponse result = await RestClient.instance.request(url: API.login, method: Config.HTTP_GET, params: login.mapToArray());

    User user = User();

    if (result.status != Status.Error) {

      user.fromJson(result.data);
      await AppCurrentState.instance.setUser(user);
    }
    return NetworkServiceResponse(
        data: user,
        status: result.status,
        message: result.message);
  }

  Future<NetworkServiceResponse<User>> actionSignUp(SignUp signUp) async {

    Map<String, dynamic> payload = await signUp.toMap();

    NetworkServiceResponse result = await RestClient.instance.request(url: API.signup, method: Config.HTTP_POST, payload: payload, isMultipart: true);

    User user = User();

    if (result.status != Status.Error) {

      user.fromJson(result.data);
      await AppCurrentState.instance.setUser(user);

      // _inData.add(user);
    }
    return NetworkServiceResponse(
        data: user,
        status: result.status,
        message: result.message);
  }

  Future<NetworkServiceResponse<void>> actionEdit(EditProfile editProfile) async {

    Map<String, dynamic> payload = await editProfile.mapToArray();
    NetworkServiceResponse result = await RestClient.instance.request(url: API.updateUserProfile, method: Config.HTTP_POST, payload: payload, isMultipart: true);

    if (result.status != Status.Error) {
      AppCurrentState.instance.user!.fromJson(result.data);
      AppCurrentState.instance.updateUser();
    }
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


  Future<NetworkServiceResponse<User>> actionDelete() async {

    NetworkServiceResponse result = await RestClient.instance.request(url: API.deleteUser, method: Config.HTTP_GET, params: {"id" : AppCurrentState.instance.getUserId()});

    if (result.status != Status.Error) {
      await AppCurrentState.instance.logout();
    }
    return NetworkServiceResponse(
        data: null,
        status: result.status,
        message: result.message);
  }

}
