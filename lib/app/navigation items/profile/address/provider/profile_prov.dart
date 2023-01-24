import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../login/sign_in/view/sign_in.dart';

class ProfileProvider extends ChangeNotifier {
//---------------------------*Icon of Address Form
  List formIcon = <Icon>[
    const Icon(Icons.arrow_forward_ios),
    const Icon(Icons.arrow_forward_ios),
    const Icon(Icons.arrow_forward_ios),
    const Icon(Icons.arrow_forward_ios),
    const Icon(Icons.arrow_forward_ios),
    const Icon(Icons.arrow_forward_ios),
  ];
//---------------------------*List of ListTile
  List title = <String>[
    "Gender",
    "Address",
    "Email",
    "Phone number",
    "change password",
    "Log out"
  ];

  List iconsprof = <Icon>[
    const Icon(Icons.person),
    const Icon(Icons.location_city),
    const Icon(Icons.email),
    const Icon(Icons.phone_android_outlined),
    const Icon(Icons.lock),
    const Icon(Icons.logout_outlined),
  ];

  List buttonprof = <Icon>[
    const Icon(Icons.arrow_forward_ios),
    const Icon(Icons.arrow_forward_ios),
    const Icon(Icons.arrow_forward_ios),
    const Icon(Icons.arrow_forward_ios),
    const Icon(Icons.arrow_forward_ios),
    const Icon(Icons.arrow_forward_ios),
  ];

  FlutterSecureStorage storage = const FlutterSecureStorage();
  void logOut(context) async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'refreshToken');

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (route) => false);
    notifyListeners();
  }
}
