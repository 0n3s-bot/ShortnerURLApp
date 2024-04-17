import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:urlshortener/network/api_endpoints.dart';
import 'package:urlshortener/network/app_interceptor.dart';

class APIService {
  final dio = createDio();

  APIService._internal();

  static final _singleton = APIService._internal();

  factory APIService() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: ApiEndpoint.kShortAPIUrl,
    ));

    dio.interceptors.addAll({
      PrettyDioLogger(
          // responseHeader: true,
          ),
      AppInterceptors(Dio(
        BaseOptions(
          baseUrl: ApiEndpoint.kShortAPIUrl,
        ),
      )),
    });
    return dio;
  }

  Future<Response> request(String endpoint, data) async {
    const apiKey = 'bd47f5cefe1c42c79a4c1794cfc90d70';
    dio.options.headers['apikey'] = apiKey;
    dio.options.headers['Content-Type'] = 'application/json';

    try {
      Response response = await dio.post(endpoint, data: data);

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        if (kDebugMode) {
          print('Dio error!');
          print('STATUS: ${e.response?.statusCode}');
          print('DATA: ${e.response?.data}');
          print('HEADERS: ${e.response?.headers}');
        }
      } else {
        if (kDebugMode) {
          print('Error sending request!');
          print(e.message);
        }
      }
      rethrow;
    }
  }
}
