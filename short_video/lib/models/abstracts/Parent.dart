abstract class Parent<T> {

  // Overridden to show info related to each object
  @override
  String toString();

  // Converting Object data into Map<String,dynamic>
  Map<String, dynamic> toMap();

  // Creating Object from Map Data
  T fromJson(dynamic json);

}