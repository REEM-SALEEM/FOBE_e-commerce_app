import 'dart:developer';

import 'package:finalproject/app/navigation%20items/cart/model/cart_single_prod_model.dart';
import 'package:finalproject/app/navigation%20items/order/model/order_argument.dart';
import 'package:finalproject/app/navigation%20items/order/model/orders_get_model.dart';
import 'package:finalproject/app/navigation%20items/order/view/buynow.dart';
import 'package:finalproject/app/navigation%20items/profile/address/model/addressget_model.dart';
import 'package:finalproject/app/services/address_services.dart';
import 'package:finalproject/app/services/cart_services.dart';
import 'package:finalproject/app/services/order_services.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class OrdersProvider with ChangeNotifier {
  List<GetOrderModel>? ordersList = [];

  GetOrderModel? getSingleOrder;
  String? deliveryDate;
  GetAddressModel? addressModel;

  bool isLoading = false;
  List<GetSingelCartProduct> cartModel = [];
  String? totalSave;
  List<String> productIds = [];

  void toOrderScreen(context, productId, cartId) {
    getSingleCart(
      context,
      productId,
      cartId,
    );
    log(cartId);
    log(productId);
    log(OrderSummaryScreenEnum.buyOneProductOrderSummaryScreen.index
        .toString());
    notifyListeners();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return OrderScreen(
              cartId: cartId,
              productId: productId,
              screenCheck:
                  OrderSummaryScreenEnum.buyOneProductOrderSummaryScreen);
        },
      ),
    );
    notifyListeners();
  }

  void getAllOrders() async {
    isLoading = true;
    notifyListeners();
    await OrderService().getAllOrders().then((value) {
      if (value != null) {
        ordersList = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
    return null;
  }

  void getSingleOrders( String orderId) async {
    isLoading = true;
    notifyListeners();
    await OrderService().getSingleOrders(orderId).then((value) {
      if (value != null) {
        getSingleOrder = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
    return null;
  }

  void cancelOrders( String orderId) async {
    isLoading = true;
    notifyListeners();
    await OrderService().cancelOrder( orderId).then((value) {
      if (value != null) {
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
    return null;
  }

  void getSingleAddress(context, String addressId) async {
    isLoading = false;
    notifyListeners();
    await AddressService().getSingleAddress(context, addressId).then((value) {
      if (value != null) {
        log("message");

        addressModel = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
    return null;
  }

  void getSingleCart(context, String productId, String cartId) async {
    isLoading = false;
    notifyListeners();
    await CartService().getSingleCart(context, productId, cartId).then((value) {
      if (value != null) {
        cartModel = value;
        notifyListeners();
        
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  void sendOrderDetials(context) {
    Share.share(
        "ShoeCart Order -Order Id:${getSingleOrder!.id},Total Products:${getSingleOrder!.products.length},Total Price:${getSingleOrder!.totalPrice},Delivery Date:$deliveryDate");
  }

  String? formatDate(String date) {
    final a = date.split(' ');
    return a[0];
  }

  String? formatCancelDate(String? date) {
    if (date != null) {
      final a = date.split('T');
      return a[0];
    } else {
      return null;
    }
  }
}
