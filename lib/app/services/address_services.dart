import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/core/api/api_endpoints.dart';
import 'package:finalproject/app/navigation%20items/profile/address/model/address_model.dart';
import 'package:finalproject/app/navigation%20items/profile/address/model/addressget_model.dart';
import 'package:finalproject/app/utils/dio_exceptions.dart';
import 'package:finalproject/app/utils/dio_interceptor.dart';

class AddressService {
  Future<String?> addAddress(CreateAddressModel model, context) async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      log('try');
      final Response response = await dios.post(
        ApiBaseUrl().baseUrl + ApiEndPoints.address,
        data: model.toJson(),
      );
      log('response');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final String result = response.data['message'];
          log(result.toString());
          return result;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<List<GetAddressModel>?> getAddress(context) async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.get(
        ApiBaseUrl().baseUrl + ApiEndPoints.address,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final List<GetAddressModel> model = (response.data as List)
              .map((e) => GetAddressModel.fromJson(e))
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

  Future<GetAddressModel?> getSingleAddress(context, String addressId) async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.get(
        "${ApiBaseUrl().baseUrl + ApiEndPoints.address}/$addressId",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final GetAddressModel model = GetAddressModel.fromJson(response.data);

          log(response.data.toString());
          return model;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e );
    }
    return null;
  }

  Future<String?> updateAddress(
      CreateAddressModel model, String addressId, context) async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      log('try');
      final Response response = await dios.patch(
        "${ApiBaseUrl().baseUrl + ApiEndPoints.address}/$addressId",
        data: model.toJson(),
      );
      log('response');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final String result = response.data['message'];
          log(result.toString());
          return result;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e);
    }
    return null;
  }

  Future<String?> deleteAddress(String addressId, context) async {
    Dio dios = await ApiInterceptor().getApiUser();
    try {
      log('try');
      final Response response = await dios.delete(
        "${ApiBaseUrl().baseUrl + ApiEndPoints.address}/$addressId",
      );
      log('response');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final String result = response.data['message'];
          log(result.toString());
          return result;
        }
      }
    } on DioError catch (e) {
      log(e.message);
      DioException().dioError(e);
    }
    return null;
  }
}
