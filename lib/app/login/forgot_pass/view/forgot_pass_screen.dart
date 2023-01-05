import 'package:finalproject/app/core/const.dart';
import 'package:finalproject/app/login/forgot_pass/view/forgot_otp.dart';
import 'package:flutter/material.dart';



class ScreenForgotPass extends StatelessWidget {
  const ScreenForgotPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhitecolor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Enter the E-mail associated with your account and we will send an email with instructions to reset your password.'),
            iHeight20,
            TextFormField(
              decoration: const InputDecoration(
                hintText: " Email",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            iHeight17,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                disabledForegroundColor: Colors.grey,
                elevation: 20,
                minimumSize: const Size(355, 60),
                shadowColor: Colors.blueGrey,
                // backgroundColor: const Color.fromARGB(255, 10, 23, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ForgotPassOtpScreen(),
                ));
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
