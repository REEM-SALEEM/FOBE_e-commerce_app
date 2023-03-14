import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finalproject/app/core/api/api_endpoints.dart';

import '../core/api/api_baseurl.dart';
import '../utils/dio_exceptions.dart';

class OtpServices {
  Dio dio = Dio();
  Future<String?> sendOtp(email, context) async {
    log('otp enabled');
    try {
      final Response response = await dio.get(
        ApiBaseUrl().baseUrl + ApiEndPoints.verifyOtp,
        queryParameters: {"email": email},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('otp created');
        log('otp done');
        return response.data['message'];
      }
    } on DioError catch (e) {
      log(e.message);
      log('otp failed');
      DioException().dioError(e, );
    }
    return null;
  }
}
