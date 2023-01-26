import 'dart:developer';
import 'package:finalproject/app/navigation%20items/cart/model/cart_single_prod_model.dart';
import 'package:finalproject/app/utils/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentProvider extends ChangeNotifier {
  bool isLoading = false;
  String paymentType = 'Online Payment';
  List<Product> products = [];
  Map<String, dynamic> options = {};
  List<String>? productId;
  String? addressId;

  Razorpay razorpay = Razorpay();

  void openCheckout(int payableAmount, context) {
    log('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    options = {
      "key": "rzp_test_boWotLKxahxvUM",
      "amount": payableAmount * 100,
      "name": "FOBE",
      "description": "Watch",
      "prefill": {"contact": "8891240830", "email": "fobe@gmail.com"},
      'external': {
        'wallets': ['paytm']
      }
    };
    notifyListeners();
    try {
      razorpay.open(options);
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse response) {
        SnackBarPop.popUp(
            context, "Payment Success${response.paymentId}", Colors.green);
      });
      notifyListeners();
    } on PaymentFailureResponse catch (e) {
      log(e.error.toString());
    }
  }

  // payment handlers.
  void handlerPaymentSuccess(PaymentSuccessResponse response, context) {
    log("Payment success");
    SnackBarPop.popUp(
        context, "Payment Success${response.paymentId}", Colors.green);
  }

  void handlerErrorFailure(PaymentFailureResponse response, context) {
    log("Payment error");
    SnackBarPop.popUp(
        context,
        'Payment Cancelled${response.code.toString()} - ${response.message}',
        Colors.red);
  }

  void handlerExternalWallet(context) {
    log("External Wallet");
    SnackBarPop.popUp(context, 'Externall Wallet', Colors.green);
  }

  // void findByProduct(context, model) {
  //   Navigator.of(context)
  //       .pushNamed(OrderPageScreen.routeName, arguments: model);
  // }

}
