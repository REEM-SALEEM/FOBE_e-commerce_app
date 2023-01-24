import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/core/api/api_endpoints.dart';
import 'package:finalproject/app/navigation%20items/cart/model/cart_add_model.dart';
import 'package:finalproject/app/navigation%20items/cart/model/cart_get_model.dart';
import 'package:finalproject/app/utils/dio_exceptions.dart';
import 'package:finalproject/app/utils/dio_interceptor.dart';

class CartService {
//---------------------------------------*ADD CART
   Future<String?> addToCart(CartModel model, context) async {
    Dio dios = await ApiInterceptor().getApiUser(context);
    try {
      final Response response = await dios.post(
        ApiBaseUrl().baseUrl + ApiEndPoints.cart,
        data: jsonEncode(model.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final cartResponse = response.data['message'];
          return cartResponse;
        }
      }
    } on DioError catch (e) {
      // log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }

//---------------------------------------*GET CART
  Future<CartGetModel?> getCart(context) async {
    Dio dios = await ApiInterceptor().getApiUser(context);
    try {
      final Response response = await dios.get(
        ApiBaseUrl().baseUrl + ApiEndPoints.cart,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final CartGetModel model = CartGetModel.fromJson(response.data);

          // log(response.data.toString());
          return model;
        }
      }
    } on DioError catch (e) {
      // log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }

//---------------------------------------*REMOVE CART
  Future<String?> removeFromCart(context, String id) async {
    Dio dios = await ApiInterceptor().getApiUser(context);
    try {
      final Response response = await dios.patch(
        ApiBaseUrl().baseUrl + ApiEndPoints.cart,
        data: {
          "product": id,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final cartRemove = response.data['message'];
        return cartRemove;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }
}