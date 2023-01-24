import 'package:finalproject/app/login/otp/provider/otp_verification_prov.dart';
import 'package:finalproject/app/login/sign_in/provider/sign_in_prov.dart';
import 'package:finalproject/app/login/sign_in/view/sign_in.dart';
import 'package:finalproject/app/login/sign_up/provider/sign_up_prov.dart';
import 'package:finalproject/app/login/splash/provider/splash_provider.dart';
import 'package:finalproject/app/login/splash/view/splash.dart';
import 'package:finalproject/app/navigation%20items/cart/provider/cart_prov.dart';
import 'package:finalproject/app/navigation%20items/home/provider/connectivity_prov.dart';
import 'package:finalproject/app/navigation%20items/product/buy%20now/buynow.dart';
import 'package:finalproject/app/navigation%20items/product/provider/product_prov.dart';
import 'package:finalproject/app/navigation%20items/product/view/product_details_screen.dart';
import 'package:finalproject/app/navigation%20items/profile/address/provider/address_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/address/provider/profile_prov.dart';
import 'package:finalproject/app/navigation%20items/wishlist/provider/wishlist_prov.dart';

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
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => ProvConnectivity()),
        //----------------
        ChangeNotifierProvider(create: (context) => SignIn()),
        ChangeNotifierProvider(create: (context) => SignUp()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => NavigationIndex()),
        ChangeNotifierProvider(create: (context) => VerifyOtpProvider()),
        //----------------
        ChangeNotifierProvider(create: (context) => HomeProv(context)),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        //----------------
        ChangeNotifierProvider(create: (context) => WishlistProv(context)),
        ChangeNotifierProvider(create: (context) => CartProvider(context)),
        ChangeNotifierProvider(create: (context) => AddressProvider(context)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          ProvDetails.routeName: (context) {
            return const ProvDetails();
          },
          OrderScreen.routeName: (context) {
            return const OrderScreen();
          },
        },
        home: const ScreenSplash(),
      ),
    );
  }
}
