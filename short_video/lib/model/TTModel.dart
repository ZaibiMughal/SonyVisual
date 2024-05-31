class TTStoryModel {
  String title;
  String description;
  String category;
  String like;
  int privacy;
  int addedBy;
  String videoUrl;
  String thumbnail;
  String sound;
  bool isFavourite = false;

  TTStoryModel({required this.title,required this.description,required this.category,required this.like,required this.videoUrl,required this.thumbnail,required this.privacy,required this.addedBy, this.isFavourite = false, this.sound = ""});
}

class TTAccountModel {
  String post;
  String like;
  String user;

  TTAccountModel(this.post, this.like, this.user);
}

class TTSearchModel {
  List<String> imageList;
  var message;
  var view;

  TTSearchModel(this.message, this.view, this.imageList);
}

class TTNotificationModel {
  var userImg;
  var msg;
  var duration;

  TTNotificationModel(this.msg, this.duration, this.userImg);
}

class TTFollowingModel {
  var userImg;
  var name;
  var isSelected = false;

  TTFollowingModel(this.userImg, this.name);
}

class TTSongModel {
  var img;
  var name;
  var value;
  var isSelected = false;

  TTSongModel(this.img, this.name, this.value);
}
