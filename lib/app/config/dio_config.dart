import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';

import 'constants.dart';

class DioService {
  static DioService _singletonHttp;
  Dio _http;

  factory DioService() {
    if (_singletonHttp == null) _singletonHttp = DioService._internal();
    return _singletonHttp;
  }
  DioService._internal() {
    _http = Dio();
    _http.options.baseUrl = AppConstants.API_URL;

    // interceptors
    _http.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          final path = options.path;
          print(path);

          if (path.contains('oauth/token')) {
            final encode = base64.encode(
              utf8.encode(AppConstants.CLIENT_SECRET),
            );
            options.headers = {
              'Authorization': 'Basic $encode',
              'Content-type': 'application/x-www-form-urlencoded'
            };
            return options;
          } else if (path.contains("public")) {
            //
            print('Metodo publico');
          } else {
            // log.d('No soy AUTH . Soy $path tokem: ${Cache.instance.token}');
            options.headers = {
              'Authorization': 'Bearer ${Cache.instance.token}',
              'Content-type': 'application/x-www-form-urlencoded'
            };
            return options;
          }
        },
        onError: (DioError e) async {
          print(e);
          return Response(statusCode: e.response.statusCode);
        },
      ),
    );
  }
  Dio get client => _http;

  dispose() {
    _http.close();
  }
}
