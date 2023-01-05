import 'package:dio/dio.dart';
import 'package:finalproject/app/login/sign_up/model/sign_up_model.dart';
import 'package:finalproject/app/navigation%20items/navigation_bar/view/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../services/sign_up_services.dart';
import '../../../services/verify_otp_services.dart';
import '../../../utils/error_snackbar.dart';

class VerifyOtpProvider extends ChangeNotifier {
  VerifyOtpService verifyOtpService = VerifyOtpService();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();
  bool isLoading = false;
  String code = '';

  void onSubmitCode(String submitCode) {
    print(submitCode);
    code = submitCode;
    notifyListeners();
  }

  void sumbitOtp(SignUpModel model, code, context) {
    print(code.length);
    if (code.length != 4) {
      SnackBarPop.popUp(context, 'Please enter the OTP', Colors.red);
    } else {
      isLoading = true;
      notifyListeners();
      verifyOtpService.verifyOtp(model.email, code, context).then(
        (value) {
          if (value != null) {
            SignupServices().signupUser(model, context).then((value) {
              if (value != null) {
                storage.write(key: 'token', value: value.accessToken);
                storage.write(key: 'refreshToken', value: value.refreshToken);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) {
                    return const BottomNavigationScreen();
                  },
                ), (route) => false);
                isLoading = false;
                notifyListeners();
              }
            });
          }
        },
      );
    }
  }
}
