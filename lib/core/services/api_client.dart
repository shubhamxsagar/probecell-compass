import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:dio/dio.dart' as dio;
import 'package:get/get_core/src/get_main.dart';

import '../theme/app_decoration.dart';

class ApiClient extends getx.GetxService {
  late dio.Dio _dio;
  var options = dio.BaseOptions(
    baseUrl: 'http://192.168.100.171:5001/api',
    connectTimeout: Duration(seconds: 15000),
    receiveTimeout: Duration(seconds: 3000),
  );

  ApiClient() {
    _dio = dio.Dio(options);
  }

  Future<ApiClient> init() async {
    return this;
  }

  void addAuthTokenInHeader(String accessToken) {
    options.headers["Authorization"] = 'Bearer ${accessToken.toString()}';
    _dio = dio.Dio(options);
  }

  void removeAuthTokenInHeader() {
    if (options.headers.containsKey("Authorization")) {
      options.headers.remove("Authorization");
    }
    _dio = dio.Dio(options);
  }

}
