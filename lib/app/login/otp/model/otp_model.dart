

import 'package:finalproject/app/login/otp/model/otp_enum.dart';
import 'package:finalproject/app/login/sign_up/model/sign_up_model.dart';

class OtpModel {
  final SignUpModel model;
  final OtpEnum screenCheck;

  OtpModel({
    required this.model,
    required this.screenCheck,
  });
}
