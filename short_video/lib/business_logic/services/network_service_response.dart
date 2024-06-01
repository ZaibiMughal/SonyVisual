import '../../config/main_config.dart';

class NetworkServiceResponse<T> {
  T? data;
  Status status;
  String message;

  NetworkServiceResponse({required this.data, required this.status, required this.message});

  NetworkServiceResponse.fromJson(Map json)
      : data = json['data'],
        status = json['status'] ? Status.Done : Status.Error,
        message = (json["messages"] as List).join("\n");

}
