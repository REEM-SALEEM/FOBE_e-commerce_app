import 'package:finalproject/app/navigation%20items/cart/view/cart_screen.dart';
import 'package:finalproject/app/navigation%20items/home/view/home_screen.dart';
import 'package:finalproject/app/navigation%20items/profile/view/profile_screen.dart';
import 'package:finalproject/app/navigation%20items/wishlist/view/wishlist_screen.dart';
import 'package:flutter/cupertino.dart';

class NavigationIndex extends ChangeNotifier {
  int currentIndex = 0;
  List pages = [
     const HomeScreen(),
    const CartScreen(),
    const WishlistScreen(),
    const ProfileScreen()
  ];

  void bottomNav(int value) {
    notifyListeners();
    currentIndex = value;
    notifyListeners();
  }
}
