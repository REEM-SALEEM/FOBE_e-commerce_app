import 'dart:developer';

import 'package:finalproject/app/navigation%20items/order/model/orders_model.dart';
import 'package:finalproject/app/services/order_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentProvider extends ChangeNotifier {
  Razorpay razorpay = Razorpay();
  List<Product> products = [];
  String? addressId;
  Map<String, dynamic> options = {};

  void setAddressId(String addressid) {
    notifyListeners();
    addressId = addressid;
    notifyListeners();
  }

  void setTotalAmount(amount, List<String> productIds, address) {
    final total = "${amount * 100}";
    final amountPayable = total.toString();
    setOptions(amountPayable);
    products = productIds.map((e) => Product(id: e)).toList();
    addressId = address;
    notifyListeners();
  }

  void setOptions(amountPayable) async {
    options = {
      'key': 'rzp_test_kfujDKwZbh4geF',
      'amount': amountPayable,
      'name': 'FOBE',
      'description': 'Mobile Phones',
      'prefill': {'contact': '8891240830', 'email': 'FOBE@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);

      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse response) {
        handlePaymentSuccess(response);
      });
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
          (PaymentFailureResponse response) {
        handlePaymentError(response);
      });
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
          (ExternalWalletResponse response) {
        handleExternalWallet(response);
      });
    } on PaymentFailureResponse catch (e) {
      log(e.error.toString());
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS:${response.paymentId}", timeInSecForIosWeb: 4);
    orderProducts(addressId!, 'ONLINE_PAYMENT');
    notifyListeners();
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR:${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
    notifyListeners();
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET:${response.walletName}", timeInSecForIosWeb: 4);
    notifyListeners();
  }

  bool loading = false;
  Future<void> orderProducts(String addressId, paymentType) async {
    loading = true;
    notifyListeners();
    final OrdersModel model = OrdersModel(
      addressId: addressId,
      paymentType: paymentType,
      products: products,
    );

    await OrderService().placeOrder(model).then((value) {
      if (value != null) {
        loading = false;
        notifyListeners();

        // Navigator.of(NavigationService.navigatorKey.currentContext!)
        //     .pushReplacement(CupertinoPageRoute(
        //   builder: (context) {
        //     return OrderDetials(
        //       orderId: value,
        //     );
        //   },
        // )).then((value) =>
        //         Navigator.of(NavigationService.navigatorKey.currentContext!)
        //             .pushAndRemoveUntil(CupertinoPageRoute(
        //           builder: (context) {
        //             return const BottomNav();
        //           },
        //         ), (route) => false));
      } else {
        loading = false;
        notifyListeners();
      }
    });
  }
}
