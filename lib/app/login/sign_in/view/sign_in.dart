import 'package:finalproject/app/core/const.dart';
import 'package:finalproject/app/login/forgot_pass/view/forgot_pass_screen.dart';
import 'package:finalproject/app/login/otp/widget/waveclipper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../sign_up/view/sign_up.dart';
import '../provider/sign_in_prov.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 240, 240),
      body: SingleChildScrollView(
        child: Consumer<SignIn>(builder: (context, value, child) {
          return Form(
            key: value.formGlobalKey,
            child: Stack(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: CustomPaint(
                  painter: PathPainter(),
                ),
              ),
              Column(
                children: [
                  // Stack(children: [
                  // ClipPath(
                  //   clipper: WaveClipper(),
                  //   child: Container(
                  //     color: const Color.fromARGB(255, 144, 180, 153),
                  //     // color: kBlackcolor,
                  //     height: size.height * 0.27,
                  //   ),
                  // ),
                  // ClipPath(
                  //   clipper: WaveClipper2(),
                  //   child: Container(
                  //     // color: const Color.fromARGB(255, 144, 180, 153),
                  //     color: Colors.black,
                  //     height: size.height * 0.25,
                  //   ),
                  // ),
                  //  Padding(
                  //    padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                  //    child: Image.asset('assets/WA1.png',width: 300,height: 300,),
                  //  ),
                  // ]),
                  // Image.asset('assets/21d4d48efa8c7d5f279726fa043e9d0b.png'),
                  const SizedBox(height: 250),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 250, 10),
                    child: Text('Sign In',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 28)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      controller: value.email,
                      decoration: const InputDecoration(
                        hintText: " Email",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                      ),
                      validator: (valuee) => value.emailValidation(valuee),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                    child: TextFormField(
                      controller: value.password,
                      obscureText: value.isobscure,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              value.visibility();
                            },
                            icon: value.icon),
                        hintText: " Password",
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                      ),
                      validator: (valuee) => value.passwordValidation(valuee),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(200, 0, 0, 7),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ScreenForgotPass(),
                          ));
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: kBlackcolor, fontSize: 15),
                        )),
                  ),
                  Consumer<SignIn>(
                    builder: (context, value, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          disabledForegroundColor: Colors.grey,
                          elevation: 20,
                          minimumSize: const Size(350, 50),
                          shadowColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {
                          Provider.of<SignIn>(context, listen: false)
                              .setNotesData();
                          Provider.of<SignIn>(context, listen: false)
                              .signIn(context);
                        },
                        child: const Text('Sign in'),
                      );
                    },
                  ),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have any account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ));
                              },
                              child: const Text(
                                'Sign Up',
                                style:
                                    TextStyle(color: kBlackcolor, fontSize: 15),
                              ))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ]),
          );
        }),
      ),
    ));
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = Colors.orange.shade300;

    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.03,
        size.width * 0.42, size.height * 0.17);
    path.quadraticBezierTo(
        size.width * 0.35, size.height * 0.32, 0, size.height * 0.29);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PathPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = Colors.black38;

    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.03,
        size.width * 0.42, size.height * 0.17);
    path.quadraticBezierTo(
        size.width * 0.35, size.height * 0.32, 0, size.height * 0.29);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
