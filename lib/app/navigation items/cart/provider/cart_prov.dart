import 'dart:developer';
import 'package:finalproject/app/navigation%20items/cart/model/cart_add_model.dart';
import 'package:finalproject/app/navigation%20items/cart/model/cart_get_model.dart';
import 'package:finalproject/app/navigation%20items/navigation_bar/provider/index_navbar.dart';
import 'package:finalproject/app/navigation%20items/navigation_bar/view/navigationbar.dart';
import 'package:finalproject/app/navigation%20items/product/view/product_details_screen.dart';
import 'package:finalproject/app/services/cart_services.dart';
import 'package:finalproject/app/utils/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  CartProvider(context) {
    getCart(context);
  }

  bool isLoading = false;
  CartGetModel? cartList;
  List<String> cartItemsId = [];
  List<String> cartitemsPayId = [];
  
  int quantity = 1;
  int totalproductCount = 1;
  int? totalSave;
  CartService service = CartService();

  //-----------------------------------------------*Get Cart Items
  void getCart(context) async {
    isLoading = true;
    notifyListeners();
    await service.getCart(context).then(
      (value) {
        if (value != null) {
          cartList = value;
          notifyListeners();
          cartItemsId = cartList!.products.map((e) => e.product.id).toList();
          cartitemsPayId = cartList!.products.map((e) => e.id).toList();
          totalSave = (cartList!.totalPrice - cartList!.totalDiscount).toInt();
          totalProductCount();
          notifyListeners();
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
        }
        return null;
      },
    );
  }

  //-----------------------------------------------*Add Cart Items
  Future addToCart(String productId, context, String size) async {
    log('here');
    isLoading = true;
    notifyListeners();
    final CartModel model = CartModel(
      size: size.toString(),
      quantity: quantity,
      productId: productId,
    );

    await service.addToCart(model, context).then((value) {
      log('here1');
      if (value != null) {
        getCart(context);
        if (value == "product added to cart successfully") {
          SnackBarPop.popUp(
              context, "Product Added To Cart Successfully", Colors.green);
        }
      } else {
        log('hjgjhg');
        null;
      }
    });
  }

//------------------------------------------------------*Remove from Cart
  void removeCart(context, productId) {
    log('get in to remove controller');
    service.removeFromCart(context, productId).then(
      (value) {
        if (value != null) {
          getCart(context);
          log(totalSave.toString());
          pop(context);
          SnackBarPop.popUp(
              context, 'Product removed from cart successfully', Colors.red);
          notifyListeners();
        } else {
          return;
        }
      },
    );
  }

//------------------------------------------------------*Quantity Inc/Dec

  void totalProductCount() {
    //-------------*Count
    int count = 0;

    for (var i = 0; i < cartList!.products.length; i++) {
      log(count.toString());
      count = count + cartList!.products[i].qty;
      notifyListeners();
    }
    totalproductCount = count;
    log("tot = $totalproductCount");
    notifyListeners();
  }

  Future<void> incrementOrDecrementQuantity(int qty, String productId,
      String productSize, int productquantity, context) async {
    final CartModel model = CartModel(
      productId: productId,
      quantity: qty,
      size: productSize.toString(),
    );
    if (qty == 1 && productquantity >= 1 || qty == -1 && productquantity > 1) {
      log("log is ${qty.toString()}");
      await CartService().addToCart(model, context).then((value) async {
        if (value != null) {
          log(value);
          await CartService().getCart(context).then((value) {
            if (value != null) {
              log("get = ${value.toString()}");
              cartList = value;
              log('true${cartList!.products[0].qty.toString()}');
              notifyListeners();

              totalProductCount();
              notifyListeners();

              cartItemsId =
                  cartList!.products.map((e) => e.product.id).toList();
              log('cartitemsid = ${cartItemsId.toString()}');
              notifyListeners();

              totalSave =
                  (cartList!.totalPrice - cartList!.totalDiscount).toInt();
              log('totalSave = ${totalSave.toString()}');
              notifyListeners();
            } else {
              null;
            }
          });
        } else {
          null;
        }
      });
    } else {
      null;
    }
  }

//-----------------------------------------------------------*Navigation------
  void pop(context) {
    Navigator.of(context).pop();
    notifyListeners();
  }

  void gotToCartFromProduct(context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return const BottomNavigationScreen();
      },
    ), (route) => false);
    Provider.of<NavigationIndex>(context, listen: false).currentIndex = 2;
    notifyListeners();
  }

  void toProductScreen(context, index) {
    Navigator.of(context)
        .pushNamed(ProvDetails.routeName, arguments: cartItemsId[index]);
  }
}
