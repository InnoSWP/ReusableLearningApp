import 'package:flutter/material.dart';
import '../authorization/authorization_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/utilities/api_settings.dart';

class Api {
  final _storage = const FlutterSecureStorage();
  final _baseUrl = ApiSettings.baseUrl;
  final _dio = Dio();

  void _refreshTokens(String? refreshToken) async {
    var response = await _dio.post(
      "$_baseUrl/users/refresh",
      queryParameters: {"Authorization": "Bearer ${_storage.read(key: 'jwtRefresh')}"}
    );
    if(response.statusCode == 200) return;

    await _storage.write(key: 'jwtRefresh', value: response.data["refresh"]);
    await _storage.write(key: 'jwtAccess', value: response.data["access"]);
  }

  Future<dynamic> post(String? url, String? accessToken, Map<dynamic, dynamic> data) async {
    // TODO
    return;
  }

  Future<dynamic> getSelfInfo() async {
    var access = _storage.read(key: "jwtAccess");
    var refresh = _storage.read(key: "jwtRefresh");

    var response = await _dio.post("http://10.91.51.187:8000/users/me/",
    queryParameters: {"Authorization": "Bearer $access"});

    return response.data;
  }

}