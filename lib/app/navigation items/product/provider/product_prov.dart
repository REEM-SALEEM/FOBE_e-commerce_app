import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  int activeIndex = 0;

  void getProductCarousel(index) {
    activeIndex = index;
    notifyListeners();
  }

  void goBackHome(context) {
    Navigator.of(context).pop();
    activeIndex = 0;
    notifyListeners();
  }
}