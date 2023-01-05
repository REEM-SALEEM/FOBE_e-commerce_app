import 'package:flutter/cupertino.dart';
import '../../cart/cart_screen.dart';
import '../../home/view/home_screen.dart';
import '../../offer/offer_screen.dart';
import '../../profile/view/profile_screen.dart';

class NavigationIndex extends ChangeNotifier {
  int currentIndex = 0;
  List pages = [
    const HomeScreen(),
    const CartScreen(),
    const OfferScreen(),
    const ProfileScreen()
  ];

  void bottomNav(int value) {
    currentIndex = value;
    notifyListeners();
  }
}
