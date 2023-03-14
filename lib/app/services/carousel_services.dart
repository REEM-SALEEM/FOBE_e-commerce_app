import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/core/api/api_endpoints.dart';
import 'package:finalproject/app/navigation%20items/home/model/carouselist_model.dart';
import 'package:finalproject/app/utils/dio_exceptions.dart';
import 'package:finalproject/app/utils/dio_interceptor.dart';

class CarouselServices {
  Future<List<CarouselModel>?> carouselUsers(context) async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response =
          await dios.get(ApiBaseUrl().baseUrl + ApiEndPoints.carousal);
      if (response.statusCode == 200) {
        log(response.data.toString());
        final List<CarouselModel> carousel = (response.data as List)
            .map((e) => CarouselModel.fromJson(e))
            .toList();
        return carousel;
      } else {
        return null;
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e, );
    }
    return null;
  }
}
