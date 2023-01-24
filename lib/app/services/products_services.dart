import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/core/api/api_endpoints.dart';
import 'package:finalproject/app/navigation%20items/home/model/productlist_model.dart';
import 'package:finalproject/app/utils/dio_exceptions.dart';
import 'package:finalproject/app/utils/dio_interceptor.dart';

class ProductServices {
  Future<List<ProductModel>?> homeProducts(context) async {
    Dio dios = await ApiInterceptor().getApiUser(context);
    try {
      final Response response =
          await dios.get(ApiBaseUrl().baseUrl + ApiEndPoints.product);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("message");
        log(response.data.toString());
        final List<ProductModel> productList = (response.data as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
            log("message");
        return productList;
      } else {
        return null;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, context);
    }
    return null;
  }
}