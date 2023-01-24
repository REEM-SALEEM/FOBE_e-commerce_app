import 'package:finalproject/app/login/splash/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void didChangeDependencies() {
    Provider.of<SplashProvider>(context, listen: false).splashTimer(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('FOBE',
          style: TextStyle(
              fontFamily: 'Comfortaa', color: Colors.red, fontSize: 28)),
    ));
  }
}
