import 'package:core_service/src/utils/logger.dart';
import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;

import 'package:package_info/package_info.dart';

class DeviceInfoService {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  final Logger logger = Logger("DeviceInfoService");

  /// It will return
  /// EX: M4-rc20
  Future<String> getDeviceId() async {
    logger.debug("Getting device ID...");

    if (Platform.isAndroid) {
      logger.debug("Getting device id for android");
      final info = await deviceInfo.androidInfo;
      logger.debug("Got android uid: ${info.id}");
      return info.id;
    }
    logger.debug("Getting device id for ios");
    final info = await deviceInfo.iosInfo;
    logger.debug("Got android uid: ${info.identifierForVendor}");

    return info.identifierForVendor;
  }

  Future<String> getDeviceModel() async {
    logger.debug("Getting device model...");
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      logger.debug("Got device model: ${androidInfo.model}");
      return androidInfo.model;
    }
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    logger.debug("Got device model: ${iosInfo.utsname.machine}");
    return iosInfo.utsname.machine;
  }

  Future<String> getAppVersion() async {
    logger.debug("Getting app version...");
    final info = await PackageInfo.fromPlatform();
    logger.debug("Got app version: ${info.version}");

    return info.version;
  }

  String getPlatformType() {
    return Platform.isIOS ? "IOS" : "ANDROID";
  }
}
