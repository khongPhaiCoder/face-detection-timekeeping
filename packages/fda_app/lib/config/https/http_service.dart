import 'dart:io';

import 'package:dio/dio.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class HttpService {
  Dio? _dio;
  header() => {"Content-Type": "application/json"};

  HttpService._privateConstructor() {
    _dio = Dio(BaseOptions(
        baseUrl: 'http://192.168.1.21:8080/api/', headers: header()));
    initInterceptors();
  }

  static final HttpService _instance = HttpService._privateConstructor();

  factory HttpService() {
    return _instance;
  }
  // Future<HttpService> init() async {
  //   _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: header()));
  //   initInterceptors();
  //   return this;
  // }

  Future setHeaderToken(String? token) async {}

  void initInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          print(
              "REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
              "=> REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (err, handler) {
          print("Error[${err.response?.statusCode}]");
          return handler.next(err);
        },
      ),
    );
  }

  Future<dynamic> request(
      {required String url,
      required Method method,
      Map<String, dynamic>? params,
      String? type,
      FormData? file}) async {
    Response response;

    try {
      if (method == Method.POST) {
        if (type != null) {
          _dio!.options.headers["Content-Type"] = "multipart/form-data";
          response = await _dio!.post(url, data: file);
          _dio!.options.headers["Content-Type"] = "application/json";
        } else {
          print('object');
          response = await _dio!.post(url, data: params);
        }
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(url);
      } else {
        response = await _dio!.get(url, queryParameters: params);
      }

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        print('object');
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something does wen't wrong");
      }
    } on SocketException catch (e) {
      print('SocketException');
      throw Exception("Not Internet Connection");
    } on FormatException catch (e) {
      print('FormatException');
      throw Exception("Bad response format");
    } on DioError catch (e) {
      print(e);
      throw "Vui lòng đăng nhập lại!";
    } catch (e) {
      print(e);
      throw Exception("Something wen't wrong");
    }
  }
}
