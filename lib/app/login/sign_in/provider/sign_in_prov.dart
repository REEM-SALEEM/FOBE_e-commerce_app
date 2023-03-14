import 'dart:developer';

import 'package:finalproject/app/login/sign_in/model/sign_in_model.dart';
import 'package:finalproject/app/navigation%20items/navigation_bar/provider/index_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../navigation items/navigation_bar/view/navigationbar.dart';
import '../../../services/sign_in_services.dart';

class SignIn extends ChangeNotifier {
  //-------------------------*Sharedprefs
  //save name
  Future<void> setNotesData() async {
    final sharedprefs = await SharedPreferences
        .getInstance(); //initialize object of shared preference
    await sharedprefs.setString('saved_name', email.text);
    notifyListeners();
  }

//---------------------------*Visibility (password)
  bool isobscure = true;
  Icon icon = const Icon(
    Icons.visibility_off,
  );

  void visibility() {
    if (isobscure == false) {
      icon = const Icon(
        Icons.visibility_off,
      );
      isobscure = true;
      notifyListeners();
    } else {
      icon = const Icon(
        Icons.visibility,
        color: Colors.black,
      );
      isobscure = false;
      notifyListeners();
    }
  }

//---------------------------*Email Validation
  final TextEditingController email = TextEditingController();

  String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This is required';
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return "Please enter a valid email address";
    } else {
      return null;
    }
  }

//---------------------------*Password Validation
  final TextEditingController password = TextEditingController();

  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This is required';
    } else if (value.length < 3) {
      return 'Should contain minimum of 4 letters';
    } else {
      return null;
    }
  }

//---------------------------*Elevated Button Validation check
  FlutterSecureStorage storage = const FlutterSecureStorage();
  SigninServices signinServices = SigninServices();
  bool isLoading = false;
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  void signIn(BuildContext context) {
    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      //---
      isLoading = true;
      notifyListeners();

      final SignInModel signinModel = SignInModel(
        email: email.text,
        password: password.text,
      );

      signinServices.signinUser(signinModel, context).then(
        (value) {
          if (value != null) {
            log("write =${value.accessToken}");
            storage.write(key: 'token', value: value.accessToken);
            storage.write(key: 'refreshToken', value: value.refreshToken);
            notifyListeners();
            storage.read(key: 'token').then((value) {
              if (value != null) {
                log('read =$value');
              }
            });
            Provider.of<NavigationIndex>(context, listen: false).currentIndex =
                0;
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const BottomNavigationScreen(),
            ));

            //---
            clearTextfield();
          } else {
            return;
          }
        },
      );
      isLoading = false;
      notifyListeners();
    }
  }

//---------------------------*Clear Textformfield
  void clearTextfield() {
    email.clear();
    password.clear();
    notifyListeners();
  }
}
