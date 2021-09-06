import 'package:core_service/src/utils/logger.dart';
import 'package:flutter/material.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> _navigatorKey =
      new GlobalKey<NavigatorState>();

  final Logger logger = Logger("NavigatorService");

  /// Singleton of navigator key
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  Future<dynamic> navigateTo(String routeName, {arg}) {
    this.logger.debug("pushNamed to $routeName with arg: $arg");

    return _navigatorKey.currentState!
        .pushNamed(routeName, arguments: routeName);
  }

  Future<dynamic> navigateReplaceTo(String routeName, {arg}) {
    this.logger.debug("pushReplacementNamed to $routeName with arg: $arg");
    return _navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arg);
  }

  void pop() {
    this.logger.debug("pop");
    _navigatorKey.currentState!.pop();
  }

  void pushNamedAndRemoveUntil(String routeName, {arg}) {
    this.logger.debug("pushNamedAndRemoveUntil to $routeName with arg: $arg");
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}
