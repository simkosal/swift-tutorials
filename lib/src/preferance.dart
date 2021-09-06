import 'dart:convert';

import 'package:core_service/src/model/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  String? phoneToken = 'phoneToken';
  String? accountToken = 'accountToken';
  Future<void> savePhoneToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(phoneToken!, value);
  }

  Future<String?> getPhoneToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(phoneToken!);
  }

  Future<void> removePhoneToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(phoneToken!);
  }

  Future<void> saveUser(AuthModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(accountToken!, json.encode(userModel));
  }

  Future<AuthModel?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final map = prefs.getString(accountToken!);
    return map != null ? AuthModel.fromJson(jsonDecode(map)) : null;
  }

  Future<void> removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(accountToken!);
  }
}
