
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditProfile {
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  File? image;

  EditProfile({
    required this.userId,
    required this.firstName,
    required this.lastName,
    this.email,
    this.image
  });

  mapToArray() async {
    Map<String,dynamic> data =  {
      'user_id' : userId,
      'first_name' : firstName,
      'last_name' : lastName,
      'email' : email
    };

    if(image != null){
      data.addAll({'uploaded_file' : await MultipartFile.fromFile(image!.path, filename: basename(image!.path))});
    }

    return data;
  }
  
}