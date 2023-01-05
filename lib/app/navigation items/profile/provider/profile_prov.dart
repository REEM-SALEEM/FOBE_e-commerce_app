
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../login/sign_in/view/sign_in.dart';

class ProfileProvider extends ChangeNotifier {
//---------------------------*List of ListTile
  List title = <String>[
    "Gender",
    "Birthday",
    "Email",
    "Phone number",
    "change password",
    "Log out"
  ];

  List iconsprof = <Icon>[
    const Icon(Icons.person, color: Colors.blue),
    const Icon(Icons.calendar_month, color: Colors.blue),
    const Icon(Icons.email, color: Colors.blue),
    const Icon(Icons.phone_android_outlined, color: Colors.blue),
    const Icon(Icons.lock, color: Colors.blue),
    const Icon(Icons.logout_outlined, color: Colors.blue),
  ];

  List buttonprof = <IconButton>[
    IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
    IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
    IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
    IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
    IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
    IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
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
