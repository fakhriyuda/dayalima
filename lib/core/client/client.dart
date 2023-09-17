import 'package:dio/dio.dart';

class Client {
  late Dio dio;
  String? token;

  Client._internal();

  static final Client _singleton = Client._internal();

  factory Client() {
    return _singleton;
  }

  Future setupClient() async {
    dio = Dio(
      BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        contentType: "application/json",
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response); // continue
        },
        onError: (DioError e, handler) {
          // Do something with response error
          return handler.next(e); //continue
        },
      ),
    );

    setDioHeader();
  }

  void setDioHeader() {
    dio.options.headers = {
      'accept': 'application/json',
    };
  }
}
