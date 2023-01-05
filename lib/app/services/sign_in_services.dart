import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/core/api/api_endpoints.dart';
import 'package:finalproject/app/login/sign_in/model/sign_in_model.dart';
import 'package:finalproject/app/login/sign_in/model/sign_in_token.dart';
import 'package:flutter/cupertino.dart';

import '../utils/dio_exceptions.dart';

class SigninServices {
  Dio dio = Dio();

  Future<SigninTokenModel?> signinUser(
      SignInModel model, BuildContext context) async {
    try {
      Response response = await dio.post(
        ApiBaseUrl().baseUrl + ApiEndPoints.signIn,
        data: jsonEncode(
          model.toJson(),
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return SigninTokenModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }
}
