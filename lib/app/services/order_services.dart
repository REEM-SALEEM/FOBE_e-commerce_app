import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/core/api/api_endpoints.dart';
import 'package:finalproject/app/navigation%20items/order/model/orders_get_model.dart';
import 'package:finalproject/app/navigation%20items/order/model/orders_model.dart';
import 'package:finalproject/app/utils/dio_exceptions.dart';
import 'package:finalproject/app/utils/dio_interceptor.dart';

class OrderService {
  Future<String?> placeOrder(OrdersModel model) async {
    try {
      final Dio dios = await ApiInterceptor().getApiUser();
      final Response response =
          await dios.post(ApiBaseUrl().baseUrl + ApiEndPoints.orders, data: {
        "addressId": model.addressId,
        "paymentType": model.paymentType,
        "products": List<dynamic>.from(model.products.map((x) => x.toJson())),
        // model.toJson(),
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final GetOrderModel order =
              GetOrderModel.fromJson(response.data['order']);
          log(order.toString());
          return order.id;
        }
      } else {
        return null;
      }
    } on DioError catch (e) {
      log('happenss');
      log(e.message.toString());
      DioException().dioError(e);
    }
    return null;
  }

  Future<List<GetOrderModel>?> getAllOrders() async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.get(
        ApiBaseUrl().baseUrl + ApiEndPoints.orders,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final List<GetOrderModel> model = (response.data as List)
              .map((e) => GetOrderModel.fromJson(e))
              .toList();

          log(response.data.toString());
          return model;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<GetOrderModel?> getSingleOrders( String orderId) async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.get(
        "${ApiBaseUrl().baseUrl + ApiEndPoints.orders}/$orderId",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final GetOrderModel model = GetOrderModel.fromJson(response.data);

          log(response.data.toString());
          return model;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<String?> cancelOrder(orderId) async {
    try {
      final Dio dios = await ApiInterceptor().getApiUser();
      final Response response = await dios.patch(
        "${ApiBaseUrl().baseUrl + ApiEndPoints.orders}/$orderId",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final order = response.data['message'];
          log(order.toString());
          return order;
        }
      } else {
        return null;
      }
    } on DioError catch (e) {
      log(e.message.toString());
      DioException().dioError(
        e,
      );
    }
    return null;
  }
}
