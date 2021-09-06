import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../core_service.dart';

class ToastsService {
  static final _log = Logger("ToastsService");

  /// Show toast with color green
  static showSuccessToast(String msg) {
    _log.debug("showSuccessToast with msg: $msg");

    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Show toast with color yellow
  static showWarningToast(String msg) {
    _log.debug("showWarningToast with msg: $msg");
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.yellow,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Show toast with color red
  static showDangerToast(String msg) {
    _log.debug("showDangerToast with msg: $msg");
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showCatchError(
    DioError dioError, {
    String somethingwrong = "Something when wrong",
    String nointernet = "No Internet connection",
    String connectiontimeout = "Connection Timeout",
    String receivetimeout = "Receive Timeout",
    String sendtimeout = "Send Timeout",
    String cancel = "Cancelled",
    Function(Response)? onResponse,
  }) async {
    switch (dioError.type) {
      case DioErrorType.other:
        PingService.checkConnectivity().then((hasInternet) {
          if (hasInternet) {
            showDangerToast(somethingwrong);
          } else {
            showDangerToast(nointernet);
          }
        });
        break;
      case DioErrorType.connectTimeout:
        showDangerToast('dioerror.connectiontimeout');
        break;
      case DioErrorType.receiveTimeout:
        showDangerToast('dioerror.receivetimeout');
        break;
      case DioErrorType.sendTimeout:
        showDangerToast('dioerror.sendtimeout');
        break;
      case DioErrorType.cancel:
        showDangerToast('dioerror.cancel');
        break;
      case DioErrorType.response:
        onResponse!(dioError.response!);
        break;

      default:
        print('dioerror.somethingwrong');
    }
  }
}
