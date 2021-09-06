import 'package:core_service/core_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ConfigService {
  Dio? https;

  static final _log = Logger("ConfigService");

  ConfigService({@required this.https});

  Future<ConfigData> networkConfigByName(String name) async {
    _log.debug("networkConfigByName with name: $name");

    final param = {"name": name};

    Response response = await https!.get(
        "/api/applicationConfiguration/getAppConfigByName",
        queryParameters: param);

    _log.debug("networkConfigByName response status: ${response.statusCode}");
    return ConfigData.fromJson(response.data['data']);
  }
}

class ConfigData {
  final String? fieldType;
  final int? id;
  final bool? isActive;
  final String? configurationType;
  final String? name;
  final String? value;
  final String? description;

  ConfigData(
      {this.id,
      this.fieldType,
      this.isActive,
      this.configurationType,
      this.name,
      this.value,
      this.description});

  factory ConfigData.fromJson(Map<String, dynamic> json) {
    return ConfigData(
      id: json['id'],
      fieldType: json['fieldType'],
      isActive: json['isActive'],
      configurationType: json['configurationType'],
      name: json['name'],
      value: json['value'],
      description: json['description'],
    );
  }
}
