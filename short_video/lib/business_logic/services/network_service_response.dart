import '../../config/main_config.dart';

class NetworkServiceResponse<T> {
  T? data;
  Status status;
  String message;

  NetworkServiceResponse({required this.data, required this.status, required this.message});

  NetworkServiceResponse.fromJson(Map json)
      : data = json['data'] ?? null,
        status = json.containsKey('status') ? json['status'] ? Status.Done : Status.Error : Status.Error,
        message = json.containsKey('messages') ? (json["messages"] as List).join("\n") : "Something went wrong";

}
