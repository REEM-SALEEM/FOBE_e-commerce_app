import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/core/api/api_endpoints.dart';
import 'package:finalproject/app/navigation%20items/home/model/categorylist_model.dart';
import 'package:finalproject/app/utils/dio_exceptions.dart';
import 'package:finalproject/app/utils/dio_interceptor.dart';

class CategoryServices {
  Future<List<CategoryModel>?> categoryUsers(context) async {
    Dio dios = await ApiInterceptor().getApiUser(context);
    try {
      final Response response =
          await dios.get(ApiBaseUrl().baseUrl + ApiEndPoints.category);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final List<CategoryModel> listCategory = (response.data as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
        return listCategory;
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