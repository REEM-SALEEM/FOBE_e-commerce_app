import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../login/sign_in/view/sign_in.dart';
import '../../../navigation_bar/provider/index_navbar.dart';

class ProfileProvider extends ChangeNotifier {
  String? savedName;
  String? savedEmail;
  String? savedPhone;

  //*get the saved name
  Future<void> getSavedData(BuildContext context) async {
    final sharedprefs = await SharedPreferences.getInstance();
    //getter method - get the saved name by key
    savedName = sharedprefs.getString('saved_name');
    notifyListeners();
    savedEmail = sharedprefs.getString('saved_email');
    notifyListeners();
    savedPhone = sharedprefs.getString('saved_phone');
    notifyListeners();
  }

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
    notifyListeners();
    await storage.delete(key: 'token');
    await storage.delete(key: 'refreshToken');

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
    Provider.of<NavigationIndex>(context, listen: false).currentIndex = 0;
    notifyListeners();

    notifyListeners();
  }
}
