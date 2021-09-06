import 'dart:io' show Platform;

import 'package:core_service/src/preferance.dart';
import 'package:core_service/src/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TokenServices {
  Dio https;
  PreferenceService preferenceService = PreferenceService();
  final String? apiKey;
  String statusCode = '1';
  Logger logger = Logger("TokenServices");

  TokenServices(this.https, {@required this.apiKey});

  Future<void> removeUserDevice(String deviceToken) async {
    final headers = {
      "deviceToken": deviceToken,
      "X-API-KEY": apiKey,
    };
    this.logger.debug("removeUserDevice: $deviceToken");

    Response response = await https.post(
      '/api/userDevice/removeUserDevice',
      options: Options(headers: headers),
    );

    if (response.data['statusCode'] == statusCode) {
      this.logger.debug("removeUserDevice Successfully");
    }
  }

  Future<void> updateUserDevice(String username, String deviceToken) async {
    this.logger.debug("removeUserDevice username:$username");
    this.logger.debug("removeUserDevice token:$deviceToken");

    final headers = {
      "deviceToken": deviceToken,
      "deviceType": Platform.isAndroid ? 'ANDROID' : 'IOS',
      "X-API-KEY": apiKey
    };

    final body = {"username": username};

    await https.put(
      '/api/userDevice/updateUserDevice',
      data: body,
      options: Options(headers: headers),
    );
    this.logger.debug("deviceUpdate Succesfully");
  }
}
