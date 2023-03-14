import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DioException {
  void dioError(
    Object e,
  ) {
    if (e is DioError) {
      if (e.response?.statusCode == 401) {
        AppToast.showToast('Invalid input', Colors.red);
        // SnackBarPop.popUp(
        //   context,
        //   'Invalid username or password',
        //   Colors.red,
        // );
      } else if (e.response?.statusCode == 400) {
        AppToast.showToast('Unknown fieldt', Colors.red);
      } else if (e.response?.statusCode == 403) {
        AppToast.showToast('User credential is not working', Colors.red);
        // SnackBarPop.popUp(
        //   context,
        //   'Forbidden',
        //   Colors.red,
        // );
      }
      // else if (e.response?.statusCode == 500) {
      // SnackBarPop.popUp(
      //   context,
      //   'Something went wrong',
      //   Colors.red,
      // );
      // }
      else if (e.toString() ==
          "[Error]: (006) Request Throttled. Over Rate limit: up to 2 per sec. See geocode.xyz/pricing") {
        AppToast.showToast('Failed, Please try again', Colors.red);
        // SnackBarPop.popUp(
        //   context,
        //   'Failed, Please try again',
        //   Colors.red,
        // );
      }
    }
    if (e is SocketException) {
      AppToast.showToast('No Internet Connection', Colors.red);
      // SnackBarPop.popUp(context, 'No Internet Connection', Colors.red);
    } else if (e is TimeoutException) {
      AppToast.showToast('Connection Timeout', Colors.red);
      // SnackBarPop.popUp(context, 'Connection Timedout', Colors.red);
    }
  }
}

class AppToast {
  static Future<void> showToast(
    String msg,
    Color color, [
    Toast toastLength = Toast.LENGTH_SHORT,
  ]) async {
    await Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: msg,
      backgroundColor: color,
      toastLength: toastLength,
    );
  }
}
