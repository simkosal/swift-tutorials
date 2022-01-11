import 'package:core_service/core_service.dart';
import 'package:core_service/src/device_info_services.dart';
import 'package:core_service/src/model/request_pin_model.dart';
import 'package:core_service/src/preferance.dart';
import 'package:core_service/src/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'utils/khmer_phone_validator.dart';

class AuthServices {
  Dio? https;
  PreferenceService preferenceService = PreferenceService();
  DeviceInfoService deviceInfoService = DeviceInfoService();

  String? pid;
  String? phoneNumber;
  final String? apiKey;

  Logger logger = Logger("AuthServices");
  AuthServices(this.https, {@required this.apiKey});

  ///  sign in step 1 todo = request pin and get PID to confirm with pin in step 2
  Future<ResponePinModel> requestPinSignIn(String phoneNumber) async {
    this.logger.debug("Phone before tranform $phoneNumber");

    final newPhone = KhmerPhoneValidator.validPhone(phoneNumber);
    this.phoneNumber = newPhone.phone;
    this.logger.debug("Phone after tranform ${this.phoneNumber}");
    final body = {
      "phoneNumber": this.phoneNumber,
    };
    final header = {
      // "deviceId": await this.deviceInfoService.getDeviceId(),
      "deviceModel": await this.deviceInfoService.getDeviceModel(),
      "X-APP-VERSION": await this.deviceInfoService.getAppVersion(),
      "X-API-KEY": this.apiKey,
    };

    this.logger.debug("requestPinSignIn with header: $header with data: $body");
    Response response = await https!.post(
      '/api/signIn/requestPIN',
      data: body,
      options: Options(
        headers: header,
      ),
    );

    this.logger.debug("requestPinSignIn Successfully");
    final result = ResponePinModel.fromJson(response.data);
    this.pid = result.data!.pID;
    return result;
  }

  /// Retry request sign in pin again with old phone number
  Future<ResponePinModel> retryRequestPinSignIn() async {
    this.logger.debug("retryRequestPinSignIn");
    return await requestPinSignIn(this.phoneNumber ?? "");
  }

  /// sign in step 2 todo = confirm and need customer to input the right pin and it save all user data and token in Preference
  Future<dynamic> confirmPinSignIn({
    required String pin,
    String? pid,
  }) async {
    final header = {
      "X-APP-VERSION": await this.deviceInfoService.getAppVersion(),
    };
    final body = {"PID": pid ?? this.pid, "PIN": pin};
    Response response = await https!.post(
      '/api/signIn/confirmPIN',
      data: body,
      options: Options(headers: header),
    );
    final authModel = AuthModel.fromJson(response.data);
    preferenceService.saveUser(authModel);
    authModel.rawJson = response.data;
    this.logger.debug("confirm Successfully");
    return authModel;
  }

  /// sign up step 1 todo = request pin and get PID to confirm with pin in step 2
  Future<ResponePinModel> requestPinSignUp(String phoneNumber) async {
    final newPhone = KhmerPhoneValidator.validPhone(phoneNumber);

    this.phoneNumber = newPhone.phone;
    final body = {
      "phoneNumber": phoneNumber,
    };
    final header = {
      "deviceId": await this.deviceInfoService.getDeviceId(),
      "deviceModel": await this.deviceInfoService.getDeviceModel(),
      "X-APP-VERSION": await this.deviceInfoService.getAppVersion(),
      "X-API-KEY": this.apiKey,
    };

    Response response = await https!.post(
      '/api/signUp/requestPIN',
      data: body,
      options: Options(
        headers: header,
      ),
    );
    final result = ResponePinModel.fromJson(response.data);

    this.pid = result.data!.pID;
    return result;
  }

  /// Retry request sign in pin again
  Future<ResponePinModel> retryRequestPinSignUp() async {
    return requestPinSignUp(this.phoneNumber ?? "");
  }

  /// sign up step 2 todo = get PID from step 1 and get customer pin number and it will return new PID to confirm and set user data in step3
  Future<ResponePinModel> confirmPinSignUp({
    required String pin,
    String? pid,
  }) async {
    final header = {
      "X-APP-VERSION": await this.deviceInfoService.getAppVersion(),
    };

    final body = {"PID": pid ?? this.pid, "PIN": pin};
    Response response = await https!.post('/api/signUp/confirmPIN',
        data: body, options: Options(headers: header));
    this.logger.debug("confirm pin Successfully");
    return ResponePinModel.fromJson(response.data);
  }

  /// sign up step 3 todo = get data form user and input with pid form step 2
  Future<AuthModel> setupUserProfile(
      {required String pid, @required User? userData}) async {
    final header = {
      "X-APP-VERSION": await this.deviceInfoService.getAppVersion(),
    };

    final body = userData!.toJson();
    body.addAll({"refPID": pid});
    Response response = await https!.post('/api/signUp/withPIN',
        data: body, options: Options(headers: header));

    final authModel = AuthModel.fromJson(response.data);
    preferenceService.saveUser(authModel);
    this.logger.debug("confirm Successfully");
    authModel.rawJson = response.data;
    return authModel;
  }

  /// Logout
  Future logOut() async {
    await https!.post('/api/v1/logout');
    this.logger.debug("logout Successfully");
    preferenceService.removeUser();
  }

  /// Get auth from share preference
  Future<AuthModel?> getLocalCurrentUser() async {
    return await preferenceService.getUser();
  }

  /// Update user profile
  Future<User> updateUserProfile(User user, int id) async {
    final update = {
      "firstName": user.firstName,
      "lastName": user.lastName,
      "sex": user.sex,
      "dateOfBirth": user.dateOfBirth,
      "email": user.email,
      "photo": user.photo
    };

    final header = {
      "X-APP-VERSION": await this.deviceInfoService.getAppVersion(),
    };

    Response response = await https!.put("/api/secusers" + "/$id",
        data: update, options: Options(headers: header));

    final data = response.data["data"];

    user.firstName = data["firstName"];
    user.lastName = data["lastName"];
    user.photo = data["photo"];
    user.phoneNumber = data["phoneNumber"];
    user.sex = data["sex"];
    user.email = data["email"];
    user.dateOfBirth = data["dateOfBirth"];

    final oldData = await preferenceService.getUser();
    oldData!.data!.userInfo = user;
    preferenceService.saveUser(oldData);
    return user;
  }

  /// Login with user and password
  Future<AuthModel> login({String? username, String? password}) async {
    final body = {"username": username, 'password': password};
    this.logger.debug("login: $body");
    final response = await https!.post('/api/v1/login', data: body);
    final authModel = AuthModel.fromJson(response.data);
    preferenceService.saveUser(authModel);
    authModel.rawJson = response.data;
    this.logger.debug("login Successfully");
    return authModel;
  }
}
