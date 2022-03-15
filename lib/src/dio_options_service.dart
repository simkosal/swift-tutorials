import 'package:core_service/core_service.dart';

/// Dio header options
///
/// Add default header
class DioOptionsService {
  Future<Map<String, String?>> getDioOptionsHeader({String? apiKey}) async {
    DeviceInfoService deviceInfoService = DeviceInfoService();
    final headers = {
      "deviceModel": await deviceInfoService.getDeviceModel(),
      "X-APP-VERSION": await deviceInfoService.getAppVersion(),
      "X-API-KEY": apiKey,
    };
    return headers;
  }
}
