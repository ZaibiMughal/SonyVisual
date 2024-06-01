class Response<T>{
  bool status;
  List<T>? data;
  String message;

  Response({
    this.status = false,
    this.data,
    this.message = "",
  });
}