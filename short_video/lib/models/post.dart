import '../business_logic/apis.dart';
import 'abstracts/Parent.dart';

class NewPost extends Parent {
  String? title;
  String? description;
  String? url;
  int? userId;

  NewPost({
    this.title,
    this.description,
    this.url,
    this.userId,
  });


  // Implement toString to make it easier to see information about
  // each User when using the print statement.
  @override
  String toString() {
    return 'Post{title: ${title}, Url: ${url}}';
  }


  
  // Convert a User into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, dynamic> toMap() {
    return {
      'title' : title,
      'description' : description,
      'url' : url,
      'user_id' : userId,
    };
  }

  @override
  fromJson(map) {}
}

class Post extends Parent {
  int? id;
  String? title;
  String? description;
  String? url;
  int? userId;
  String? username;
  String? thumbnail;
  int? isFavorite;
  int? totalLikes;
  String? userThumbnail;

  Post({
    this.id,
    this.title,
    this.description,
    this.url,
    this.userId,
    this.username,
    this.thumbnail,
    this.isFavorite,
    this.totalLikes,
    this.userThumbnail,
  });


  // Implement toString to make it easier to see information about
  // each User when using the print statement.
  @override
  String toString() {
    return 'Post{title: ${title}, Url: ${url}}';
  }



  // Convert a User into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'username' : username,
      'url' : url,
      'user_id' : userId,
      'thumbnail' : thumbnail,
      'is_favorite' : isFavorite,
      'total_likes': totalLikes,
      'user_thumbnail': userThumbnail
    };
  }

  @override
  fromJson(map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    url = map['url'];
    userId = map['user_id'];
    username = map['username'];
    thumbnail = map['thumbnail'];
    isFavorite = map['is_favorite'];
    totalLikes = map['total_likes'];
    userThumbnail = map['user_thumbnail'];
  }

  getUserImage(){
    return userThumbnail ?? "https://admin.sonyvisual.com/images/logo.png";
  }
}