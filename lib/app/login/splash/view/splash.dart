import 'package:finalproject/app/login/splash/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              curve: Curves.bounceOut,
              builder: (context, value, child) {
                return Image(
                  height: value,
                  image: const AssetImage(
                    'assets/fobehome.png',
                  ),
                );
              },
              duration: const Duration(seconds: 3),
              tween: Tween<double>(begin: 20, end: 100),
            ),
            LoadingAnimationWidget.prograssiveDots(
              color: Colors.orange,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
