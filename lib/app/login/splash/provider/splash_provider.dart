import 'dart:async';
import 'dart:developer';
import 'package:finalproject/app/login/sign_in/view/sign_in.dart';
import 'package:finalproject/app/navigation%20items/navigation_bar/view/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashProvider extends ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? onboardValue;
  String? signinCheck;

  void splashTimer(context) {
    Timer(
      const Duration(seconds: 3),
      () async {
        onboardValue = await storage.read(key: 'onboard');
        signinCheck = await storage.read(key: 'token');
        log(signinCheck.toString());
        if (signinCheck != null) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return const BottomNavigationScreen();
            },
          ), (route) => false);
        } else {
          if (onboardValue != null) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) {
                return const SignInScreen();
              },
            ), (route) => false);
          } else {}
        }
      },
    );
  }
}
