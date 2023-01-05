import 'package:finalproject/app/login/otp/provider/otp_verification_prov.dart';
import 'package:finalproject/app/login/sign_in/provider/sign_in_prov.dart';
import 'package:finalproject/app/login/sign_up/provider/sign_up_prov.dart';
import 'package:finalproject/app/login/splash/view/splash.dart';
import 'package:finalproject/app/navigation%20items/profile/provider/profile_prov.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/navigation items/home/provider/home_prov.dart';
import 'app/navigation items/navigation_bar/provider/index_navbar.dart';

void main() async {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignIn()),
        ChangeNotifierProvider(create: (context) => SignUp()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => NavigationIndex()),
        ChangeNotifierProvider(create: (context) => VerifyOtpProvider()),
        //----------
        ChangeNotifierProvider(create: (context) => HomeProv(context)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const ScreenSplash(),
      ),
    );
  }
}
