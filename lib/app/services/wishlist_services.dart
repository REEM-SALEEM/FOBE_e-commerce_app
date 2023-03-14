import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/core/api/api_endpoints.dart';
import 'package:finalproject/app/navigation%20items/wishlist/model/wishlist_model.dart';
import 'package:finalproject/app/utils/dio_exceptions.dart';
import 'package:finalproject/app/utils/dio_interceptor.dart';

class WishlistService {
  Future<int?> addOrRemoveWishlist(context, productId) async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response =
          await dios.post(ApiBaseUrl().baseUrl + ApiEndPoints.wishlist, data: {
        'product': productId,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.statusCode;
      } else if (response.statusCode == 204) {
        return response.statusCode;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, );
    }
    return null;
  }

  Future<WishListModel?> getWishlist(context) async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.get(
        ApiBaseUrl().baseUrl + ApiEndPoints.wishlist,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final WishListModel model = WishListModel.fromJson(response.data);
        return model;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e);
    }
    return null;
  }
}