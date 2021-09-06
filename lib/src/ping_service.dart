import 'dart:io';

import '../core_service.dart';

class PingService {
  static final Logger _logger = Logger("PingService");

  static Future<bool> checkConnectivity() async {
    late bool connect;
    try {
      _logger.debug("Start checkConnectivity 🏃🏽‍♀️");
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _logger.debug("You are connect to internect ☹️");
        connect = true;
      }
    } on SocketException catch (_) {
      _logger.debug("You are not connect to internect 🤦🏻‍♂️");
      connect = false;
    }
    return connect;
  }
}
