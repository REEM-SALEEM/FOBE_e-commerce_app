import 'package:finalproject/app/login/otp/provider/otp_verification_prov.dart';
import 'package:finalproject/app/login/sign_up/model/sign_up_model.dart';
import 'package:finalproject/app/login/sign_up/provider/sign_up_prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

import '../widget/waveclipper.dart';

class OtpScreen extends StatelessWidget {
  final SignUpModel model;
  const OtpScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 240, 240),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Stack(
                  // alignment: AlignmentDirectional.center,
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          color: const Color.fromARGB(255, 60, 157, 86),
                          height: size.height * 0.27,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          color: const Color.fromARGB(255, 226, 224, 118),
                          height: size.height * 0.29,
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 80),
                        color: const Color.fromARGB(255, 36, 53, 102),
                        height: size.height * 0.25,
                        alignment: Alignment.center,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 55, 0, 0),
                      child: Center(
                        child: Text(
                          'OTP Verification',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.20),

              const Text(
                'Enter the 4 Digit Code',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              Consumer<VerifyOtpProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return OtpTextField(
                    textStyle: const TextStyle(color: Colors.black),
                    numberOfFields: 4,
                    borderColor: Colors.grey,
                    enabledBorderColor: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                    showFieldAsBox: true,
                    onSubmit: (String verificationCode) {
                      value.onSubmitCode(verificationCode);
                    },
                  );
                },
              ),
              const SizedBox(height: 30),
              Consumer2<VerifyOtpProvider, SignUp>(
                builder: (BuildContext context, value, value1, Widget? child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      disabledForegroundColor: Colors.grey,
                      elevation: 20,
                      minimumSize: const Size(100, 40),
                    ),
                    onPressed: () {
                      value.sumbitOtp(model, value.code, context);
                    },
                    child: const Text('Verify'),
                  );
                },
              ),
              // AuthElevatedButton(
              //   label: 'Verify',
              //   onPressed: () {
              //     Get.to(ResetPasswordScreen());
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
