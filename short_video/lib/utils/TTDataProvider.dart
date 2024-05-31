import 'package:short_video/model/TTModel.dart';
import 'package:short_video/utils/TTConstant.dart';

import 'TTImages.dart';

List<TTStoryModel> getStoryData() {
  List<TTStoryModel> mList = [];
  mList.add(TTStoryModel(title: TTAppName, description: "Making Short Videos", category:  "comedy", like: "10", privacy: 1, addedBy: 1, videoUrl: "$baseUrl/short_video.mp4", thumbnail: TT_ic_logo));
  mList.add(TTStoryModel(title: TTAppName, description: "Making Short Videos", category:  "comedy", like: "10", privacy: 1, addedBy: 1, videoUrl: "$baseUrl/short_video.mp4", thumbnail: TT_ic_logo));
  mList.add(TTStoryModel(title: TTAppName, description: "Making Short Videos", category:  "comedy", like: "10", privacy: 1, addedBy: 1, videoUrl: "$baseUrl/short_video.mp4", thumbnail: TT_ic_logo));
  mList.add(TTStoryModel(title: TTAppName, description: "Making Short Videos", category:  "comedy", like: "10", privacy: 1, addedBy: 1, videoUrl: "$baseUrl/short_video.mp4", thumbnail: TT_ic_logo));
  mList.add(TTStoryModel(title: TTAppName, description: "Making Short Videos", category:  "comedy", like: "10", privacy: 1, addedBy: 1, videoUrl: "$baseUrl/short_video.mp4", thumbnail: TT_ic_logo));
  return mList;
}

List<TTAccountModel> getAccountData() {
  List<TTAccountModel> mList = [];
  mList.add(TTAccountModel(TT_ic_user, "100K", TT_ic_user));
  mList.add(TTAccountModel(TT_ic_user, "50", TT_ic_user));
  mList.add(TTAccountModel(TT_ic_user, "50", TT_ic_user));
  mList.add(TTAccountModel(TT_ic_user, "50", TT_ic_user));
  mList.add(TTAccountModel(TT_ic_user, "50", TT_ic_user));
  mList.add(TTAccountModel(TT_ic_user, "50", TT_ic_user));
  mList.add(TTAccountModel(TT_ic_user, "50", TT_ic_user));
  return mList;
}

List<TTAccountModel> getAccount() {
  List<TTAccountModel> mList = [];
  mList.add(TTAccountModel("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL5H5Uox180rYM6EgWG1n2Zr_q0CZQYB2YN8YkADtsSA&s", "50", TT_ic_user));
  mList.add(TTAccountModel("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL5H5Uox180rYM6EgWG1n2Zr_q0CZQYB2YN8YkADtsSA&s", "50", TT_ic_user5));
  mList.add(TTAccountModel("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL5H5Uox180rYM6EgWG1n2Zr_q0CZQYB2YN8YkADtsSA&s", "150", TT_ic_user1));
  mList.add(TTAccountModel("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL5H5Uox180rYM6EgWG1n2Zr_q0CZQYB2YN8YkADtsSA&s", "150", TT_ic_user1));
  mList.add(TTAccountModel("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL5H5Uox180rYM6EgWG1n2Zr_q0CZQYB2YN8YkADtsSA&s", "150", TT_ic_user1));
  mList.add(TTAccountModel("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL5H5Uox180rYM6EgWG1n2Zr_q0CZQYB2YN8YkADtsSA&s", "150", TT_ic_user1));
  return mList;
}

List<String> mList2 = [
  "https://media.giphy.com/media/NU8tcjnPaODTy/giphy.gif",
  "https://media.giphy.com/media/l4Ep71LWjYR1eCPXq/giphy.gif",
];
List<String> mList1 = [
  "https://media.giphy.com/media/VIoW7Fncu19GKDrQsX/giphy.gif",
];

List<TTSearchModel> getSearchData() {
  List<TTSearchModel> mList = [];
  mList.add(TTSearchModel("mixChallenge", "83.1M", mList1));
  mList.add(TTSearchModel("mixChallenge", "81.1M", mList2));
  mList.add(TTSearchModel("mixChallenge", "83.1M", mList2));
  return mList;
}

List<TTNotificationModel> getNotificationData() {
  List<TTNotificationModel> mList = [];
  mList.add(TTNotificationModel("New DIY hairstyle 🤣🤣", "1h", TT_ic_user1));
  mList.add(TTNotificationModel("Hy there...!!", "3h", TT_ic_user2));
  mList.add(TTNotificationModel("VIRAL! Did he just jump out off a MARVEL movie?", "3h", TT_ic_user3));
  mList.add(TTNotificationModel("New Challenge 🤣", "3h", TT_ic_user5));
  return mList;
}

List<TTFollowingModel> getFollowingData() {
  List<TTFollowingModel> mList = [];
  mList.add(TTFollowingModel(TT_ic_guest4, "John smith"));
  mList.add(TTFollowingModel(TT_ic_user, "Lee"));
  mList.add(TTFollowingModel(TT_ic_guest3, "Paul"));
  mList.add(TTFollowingModel(TT_ic_guest8, "Lia Smith"));
  mList.add(TTFollowingModel(TT_ic_guest9, "Kali"));
  return mList;
}

List<TTFollowingModel> getFanData() {
  List<TTFollowingModel> mList = [];
  mList.add(TTFollowingModel(TT_ic_guest1, "Guest"));
  mList.add(TTFollowingModel(TT_ic_guest2, "Lee"));
  mList.add(TTFollowingModel(TT_ic_guest3, "Paul"));
  mList.add(TTFollowingModel(TT_ic_guest4, "Smith"));
  mList.add(TTFollowingModel(TT_ic_guest5, "@Lee"));
  mList.add(TTFollowingModel(TT_ic_guest6, "Tom"));
  mList.add(TTFollowingModel(TT_ic_guest7, "Jerry"));
  mList.add(TTFollowingModel(TT_ic_guest8, "Lia Smith"));
  mList.add(TTFollowingModel(TT_ic_guest9, "Kali"));
  mList.add(TTFollowingModel(TT_ic_guest10, "Nik Jon"));
  return mList;
}

List<TTSongModel> getSongData() {
  List<TTSongModel> mList = [];
  mList.add(TTSongModel(TT_ic_music1, "Nach Meri Jann", "Guru Tanishk Bagchi"));
  mList.add(TTSongModel(TT_ic_music2, "What is your name", "Anonymous"));
  mList.add(TTSongModel(TT_ic_music3, "Josh Anthem", "Clinton Cerejo"));
  mList.add(TTSongModel(TT_ic_music4, "Halloween Sounds 1", "Fayaz"));
  mList.add(TTSongModel(TT_ic_music1, "Halloween Sounds 5", "Rizwaa"));
  mList.add(TTSongModel(TT_ic_music2, "Funny slap", "John"));
  mList.add(TTSongModel(TT_ic_music3, "Funny laugh", "Anonymous"));
  mList.add(TTSongModel(TT_ic_music4, "Halloween Sounds 13", "Anjo"));

  return mList;
}
