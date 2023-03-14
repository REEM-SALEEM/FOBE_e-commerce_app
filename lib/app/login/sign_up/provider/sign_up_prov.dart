import 'dart:developer';

import 'package:finalproject/app/login/otp/view/otp_screen.dart';
import 'package:finalproject/app/login/sign_up/model/sign_up_model.dart';
import 'package:finalproject/app/services/otp_services.dart';
import 'package:finalproject/app/services/sign_up_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends ChangeNotifier {
  // //-------------------------*Sharedprefs
  //save name
  Future<void> setNotesData() async {
    final sharedprefs = await SharedPreferences
        .getInstance(); //initialize object of shared preference
    await sharedprefs.setString('saved_name', email.text);
    notifyListeners();
  }
//---------------------------*Username Validation
  final TextEditingController fullname = TextEditingController();

  usernameValidation(String? value) {
    if (value!.isEmpty) {
      notifyListeners();
      return 'This is required';
    } else if (value.length < 3) {
      notifyListeners();
      return 'Should contain minimum of 4 letters';
    }
    return null;
  }

//---------------------------*Email Validation
  final TextEditingController email = TextEditingController();

  emailValidation(String? value) {
    if (value!.isEmpty) {
      return 'This is required';
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return "Please enter a valid email address";
    } else {
      return null;
    }
  }

//---------------------------*Mobile Number Validation
  final TextEditingController phone = TextEditingController();

  phoneValidation(String? value) {
    if (value!.isEmpty) {
      notifyListeners();
      return 'This is required';
    } else if (value.length < 10) {
      notifyListeners();
      return 'Should contain 10 numbers';
    } else if (value.length > 10) {
      notifyListeners();
      return 'Should not contain more than 10 numbers';
    }
    return null;
  }

//---------------------------*Password Validation
  final TextEditingController password = TextEditingController();
  bool isobscure = true;

  passwordValidationn(String? value) {
    if (value == null || value.isEmpty) {
      notifyListeners();
      return 'This is required';
    } else if (value.length < 3) {
      notifyListeners();
      return 'Should contain minimum of 4 letters';
    }
    return null;
  }

//---------------------------*Confirm Password Validation
  final TextEditingController confirmpassword = TextEditingController();

  confirmpasswordValidationn(String? value) {
    if (value == null || value.isEmpty) {
      notifyListeners();
      return 'This is required';
    } else if (value.length < 3) {
      notifyListeners();
      return 'Should contain minimum of 4 letters';
    } else if (value != password.text) {
      notifyListeners();
      return "Passwords doesn't match";
    }
    return null;
  }

//---------------------------*Elevated Button Validation check
  SignupServices signupServices = SignupServices();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> signupUser(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      isLoading = true;
      notifyListeners();

      final model = SignUpModel(
        fullName: fullname.text,
        email: email.text,
        phone: phone.text,
        password: password.text,
      );

      await OtpServices().sendOtp(model.email, context).then((value) {
        if (value != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return OtpScreen(
                  model: model,
                );
              },
            ),
          );
          notifyListeners();
          clearTextfield();
        } else {
          return;
        }
      });

      isLoading = false;
      notifyListeners();
    }
  }

//---------------------------*Clear Textformfield
  void clearTextfield() {
    fullname.clear();
    email.clear();
    phone.clear();
    password.clear();
    confirmpassword.clear();
  }
}
