import '../business_logic/apis.dart';
import 'abstracts/Parent.dart';

class User extends Parent {
  int id;
  String? firstName;
  String? lastName;
  int? type;
  String? email;
  String? thumbnail;

  User({
    this.id = 0,
    this.firstName,
    this.lastName,
    this.email,
    this.thumbnail,
    this.type
  });


  getId(){
    return id;
  }

  // Implement toString to make it easier to see information about
  // each User when using the print statement.
  @override
  String toString() {
    return 'User{id: $id, firstName: ${getFirstName()}, lastName: ${getLastName()}, email: ${getEmail()}}';
  }

  getFirstName(){
    return firstName;
  }

  getLastName(){
    return lastName;
  }

  getFullName(){
    return "${firstName!} ${lastName!}";
  }

  getEmail(){
    return email ?? lastName;
  }

  getPhotoUrl(){
    return thumbnail ?? 'https://admin.sonyvisual.com/images/logo.png';
  }


  // Convert a User into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'first_name' : firstName,
      'last_name' : lastName,
      'email' : email,
      'thumbnail' : thumbnail,
      'type' : type
    };
  }

  fromMap(map) {
    id = map['id'];
    firstName = map['first_name'];
    lastName = map['last_name'];
    email = map['email'];
    type = map['type'];
    thumbnail = map['thumbnail'] ?? 'https://admin.sonyvisual.com/images/logo.png';
  }


  @override
  fromJson(map) {
    id = map['id'];
    firstName = map['first_name'];
    lastName = map['last_name'];
    email = map['email'];
    type = map['type'] ?? 0;
    thumbnail = map['thumbnail'] ?? 'https://admin.sonyvisual.com/images/logo.png';
  }
}