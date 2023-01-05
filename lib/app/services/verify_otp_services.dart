import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finalproject/app/core/api/api_endpoints.dart';

import '../core/api/api_baseurl.dart';
import '../utils/dio_exceptions.dart';

class VerifyOtpService {
  Dio dio = Dio();
  Future<String?> verifyOtp(email, otpCode, context) async {
    try {
      final Response response = await dio.post(
        ApiBaseUrl().baseUrl + ApiEndPoints.verifyOtp,
        data: {
          'email': email,
          'otp': otpCode,
        },
      );
      log(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('otp verified');
        return response.data['message'];
      }
    } on DioError catch (e) {
      log(e.message);
      log('verification faliled');
      DioException().dioError(e, context);
    }
    return null;
  }
}
