import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:short_video/business_logic/apis.dart';
import 'package:short_video/utils/utils.dart';

import '../../config/main_config.dart';
import 'network_service_response.dart';

class RestClient {
  Dio? _dio;
  Response? _response;

  RestClient._(){
    init();
  }

  // Singleton instance
  static final RestClient _singleton = RestClient._();

  // Singleton accessor
  static RestClient get instance => _singleton;

  init(){
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('JUST_SKATE:Vob6ZBy6nOLj6YhG'))}';
    _dio = Dio(BaseOptions(
      baseUrl: API.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        HttpHeaders.authorizationHeader: basicAuth,
        HttpHeaders.acceptHeader : "*/*",
        HttpHeaders.contentTypeHeader : "application/json",
      },
      validateStatus: (status) {
        return status! < 500;
      },
      // followRedirects: false,
      // contentType: Headers.jsonContentType,
      // responseType: ResponseType.json,
    ));
    //
    _dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 200));

    _dio!.interceptors.add(CustomInterceptors());

  }

  Future<NetworkServiceResponse> request({required String url, required String method, Map<String, dynamic>? params, Map<String, dynamic>? payload, bool isMultipart = false}) async {
    try {
      bool connectionStatus = await Utils.isUserOnline();
      if(!connectionStatus){
        throw DioError.connectionError(requestOptions: RequestOptions(path: url,method: method), reason: "connection error");
      }

      if(method == Config.HTTP_DOWNLOAD){
        _response = await _dio!.download(
          url,
          '${(await getTemporaryDirectory()).path}pub.html',
          queryParameters: params,
          data: payload != null ? FormData.fromMap(payload) : null,
          onReceiveProgress: (count, total) {
            if (total != -1) {
              print('${(count / total * 100).toStringAsFixed(0)}%');
            }
          },
        );
      } else {
        Options options = Options(method: method);
        if(isMultipart == true) {
          options.headers =
          {HttpHeaders.contentTypeHeader: "multipart/form-data"};
        } else {
          options.headers =
          {HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"};
        }
        _response = await _dio!.request(url,
          options: Options(method: method),
          queryParameters: params,
          data: payload != null ? FormData.fromMap(payload) : null,
          onSendProgress: (count, total) {
            if (total != -1) {
              // print('${(count / total * 100).toStringAsFixed(0)}%');
            }
          },
          onReceiveProgress: (count, total) {
            if (total != -1) {
              // print('${(count / total * 100).toStringAsFixed(0)}%');
            }
          },
        );
      }
      return NetworkServiceResponse.fromJson(_response!.data);
    } on DioError catch (e) {
      print(e.error);
      return NetworkServiceResponse(
          data: null, status: Status.Error, message:  "Something went wrong");
    } catch (e){
      print(e);
      return NetworkServiceResponse(
          data: null, status: Status.Error, message: "Something went wrong");
    }
  }

  Future<NetworkServiceResponse> getRequest({required String url, Map<String, dynamic>? params}) async {
    try {
      _response = await _dio!.get(url,
        queryParameters: params,
        onReceiveProgress: (count, total) => print('received ${count / total}'),
      );
      return NetworkServiceResponse.fromJson(_response!.data);
    } on DioError catch (e) {
      return NetworkServiceResponse(data: null, status: Status.Error, message: e.message!);
    }
  }
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}



