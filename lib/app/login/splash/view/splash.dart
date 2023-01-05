import 'package:finalproject/app/login/sign_in/view/sign_in.dart';
import 'package:flutter/material.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('shope',
          style: TextStyle(
              fontFamily: 'Comfortaa', color: Colors.red, fontSize: 28)),
    ));
  }
}
