import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class SignUp {
  String firstName;
  String lastName;
  String password;
  String email;
  File? image;

  SignUp({required this.firstName, required this.lastName, required this.email, required this.password, this.image});

  toMap() async {

    Map<String, dynamic> body = {
      'first_name' : firstName,
      'last_name' : lastName,
      'password' : password,
      'email' : email,
    };

    if(image != null){
      body.addAll({'uploaded_file' : await MultipartFile.fromFile(image!.path, filename: basename(image!.path))});
    }

    return body;
  }

}
