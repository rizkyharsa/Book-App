import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:book_app/common/constant.dart';

class RestService {
  Dio get dio => _dio();

  Dio _dio() {
    final options = BaseOptions(
      connectTimeout: const Duration(milliseconds: connectionTimeout),
      receiveTimeout: const Duration(milliseconds: receiveTimeout),
      contentType: 'application/json;charset=utf-8',
    );
    var dio = Dio(options);
    if (foundation.kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        compact: true,
      ));
    } else {}
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response != null) {
          if (error.response!.statusCode == 401) {
            final option = Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers,
            );
            final cloneReq = await dio.request(
              error.requestOptions.path,
              options: option,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
            );
            return handler.resolve(cloneReq);
          }
        } else {
          return handler.next(error);
        }
      },
    ));
    return dio;
  }
}
