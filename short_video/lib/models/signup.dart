import 'package:short_video/business_logic/apis.dart';

class SignUp {
  String firstName;
  String lastName;
  String password;
  String email;
  String image;

  SignUp({required this.firstName, required this.lastName, required this.email, required this.password, this.image = '${API.baseUrl}images/logo.png'});

  toMap(){

    Map<String, dynamic> body = {
      'first_name' : firstName,
      'last_name' : lastName,
      'password' : password,
      'email' : email,
      'image' : image,
    };
    return body;
  }

}
