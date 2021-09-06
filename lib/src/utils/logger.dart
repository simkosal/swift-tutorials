import 'package:flutter/foundation.dart';

class Logger {
  final String serviceName;

  Logger(this.serviceName);

  debug(String message) {
    debugPrint("[${this.serviceName}]: $message");
  }
}
