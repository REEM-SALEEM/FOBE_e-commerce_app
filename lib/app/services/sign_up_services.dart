import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../core/api/api_baseurl.dart';
import '../core/api/api_endpoints.dart';
import '../login/sign_up/model/sign_up_model.dart';
import '../login/sign_up/model/signup_token.dart';
import '../utils/dio_exceptions.dart';

class SignupServices {
  Dio dio = Dio();

  Future<SignUpTokenModel?> signupUser(
      SignUpModel value, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiBaseUrl().baseUrl + ApiEndPoints.signUp,
        data: jsonEncode(
          value.toJson(),
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data.toString());
        final signupResponse = SignUpTokenModel.fromJson(response.data);
        print(response.data.toString());
        return signupResponse;
      }
    } on DioError catch (e) {
      print(e.message);
      DioException().dioError(e, );
    }
    return null;
  }
}
