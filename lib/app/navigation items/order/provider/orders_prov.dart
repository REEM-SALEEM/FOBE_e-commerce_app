import 'dart:developer';

import 'package:finalproject/app/navigation%20items/cart/model/cart_single_prod_model.dart';
import 'package:finalproject/app/navigation%20items/order/model/orders_get_model.dart';
import 'package:finalproject/app/navigation%20items/profile/address/model/addressget_model.dart';
import 'package:finalproject/app/services/address_services.dart';
import 'package:finalproject/app/services/cart_services.dart';
import 'package:finalproject/app/services/order_services.dart';
import 'package:flutter/foundation.dart';

class OrdersProvider extends ChangeNotifier {
  bool isLoading = false;

  List<GetOrderModel> orderList = [];
  GetOrderModel? getSingleOrder;
  GetAddressModel? addressModel;
  List<GetSingelCartProduct> cartModel = [];
  int? totalSave;

  void getAllOrders(context) async {
    isLoading = true;
    notifyListeners();
    await OrderService().getAllOrders(context).then((value) {
      if (value != null) {
        orderList = value;
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

  void getSingleOrders(context, String orderId) async {
    isLoading = true;
    notifyListeners();
    await OrderService().getSingleOrders(context, orderId).then((value) {
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

  void cancelOrders(context, String orderId) async {
    isLoading = true;
    notifyListeners();
    await OrderService().cancelOrder(context, orderId).then((value) {
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
        totalSave = (cartModel[0].price - cartModel[0].discountPrice).round();
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
    return null;
  }
}
