import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:finalproject/app/core/api/api_endpoints.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/api/api_baseurl.dart';
import 'dio_exceptions.dart';

class ApiInterceptor {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();

  Future<Dio> getApiUser(context) async {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          //--------------------onrequest
          final token = await storage.read(key: 'token');
          dio.interceptors.clear();
          options.headers.addAll({"Authorization": "Bearer $token"});
          return handler.next(options);
        },
        onResponse: (response, handler) {
          //--------------------onresponse
          return handler.next(response);
        },
        onError: (DioError e, handler) async {
          //--------------------onerror
          if (e.response != null) {
            if (e.response?.statusCode == 403 &&
                e.response?.data['message'] == 'Forbidden') {
              log('token expired');
              RequestOptions requestOptions = e.requestOptions;
              try {
                final refreshToken = await storage.read(key: 'refreshToken');
                log(refreshToken.toString());
                final opts = Options(method: requestOptions.method);
                dio.options.headers["refresh"] = "Bearer $refreshToken";
                final Response response = await dio.get(
                  ApiBaseUrl().baseUrl + ApiEndPoints.refreshToken,
                  options: opts,
                );
                if (response.statusCode! == 200) {
                  log(response.data.toString());
                  final token = response.data['accessToken'];
                  final refreshToken = response.data['refreshToken'];
                  await storage.delete(key: 'token');
                  await storage.delete(key: 'refreshToken');
                  storage.write(key: 'token', value: token);
                  storage.write(key: 'refreshToken', value: refreshToken);
                }
              } catch (e) {
                DioException().dioError(e, context);
              }
              try {
                final token = await storage.read(key: 'token');
                final opts = Options(method: requestOptions.method);
                dio.options.headers["Authorization"] = "Bearer $token";
                final response = await dio.request(
                  requestOptions.path,
                  options: opts,
                  cancelToken: requestOptions.cancelToken,
                  onReceiveProgress: requestOptions.onReceiveProgress,
                  data: requestOptions.data,
                  queryParameters: requestOptions.queryParameters,
                );
                return handler.resolve(response);
              } catch (e) {
                DioException().dioError(e, context);
              }
            }
          } else {
            handler.next(e);
          }
        },
      ),
    );
    return dio;
  }
}
