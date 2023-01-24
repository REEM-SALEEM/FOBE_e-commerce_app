import 'package:finalproject/app/navigation%20items/product/view/product_details_screen.dart';
import 'package:finalproject/app/navigation%20items/wishlist/model/wishlist_model.dart';
import 'package:finalproject/app/services/wishlist_services.dart';
import 'package:finalproject/app/utils/error_snackbar.dart';
import 'package:flutter/material.dart';

class WishlistProv extends ChangeNotifier {
  WishlistProv(context) {
    getWishlist(context);
  }
  bool isLoading = false;
  WishListModel? model;
  List<dynamic> wishList = [];
  WishlistService service = WishlistService();
  dynamic isFavorite = false;
  void bottomNav(dynamic value) {
    isFavorite = value;
    notifyListeners();
  }

  void getWishlist(context) async {
    isLoading = true;
    notifyListeners();
    await service.getWishlist(context).then(
      (value) {
        if (value != null) {
          model = value;
          notifyListeners();
          wishList = model!.products.map((e) => e.product.id).toList();
          notifyListeners();
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
        }
      },
    );
  }

  void addOrRemoveFromWishlist(context, String productId) async {
    isLoading = true;
    notifyListeners();
    await service.addOrRemoveWishlist(context, productId).then((value) {
      if (value != null) {
        service.getWishlist(context).then((value) {
          if (value != null) {
            model = value;
            notifyListeners();
            getWishlist(context);
            isLoading = false;
            notifyListeners();
          } else {
            isLoading = false;
            notifyListeners();
          }
        });
        if (value == 201) {
          SnackBarPop.popUp(context, 'Item added to Wishlist ', Colors.green);
        }
        if (value == 204) {
          SnackBarPop.popUp(context, 'Item removed from Wishlist ', Colors.red);
        }
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  WishListModel findById(String id) {
    return wishList.firstWhere((element) => element.id == id);
  }

  void toProductScreen(context, index) {
    Navigator.of(context)
        .pushNamed(ProvDetails.routeName, arguments: wishList[index]);
  }
}
