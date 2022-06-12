import 'package:flutter/material.dart';
import 'package:reusable_app/models/utilities/server_settings.dart';
import 'authorization_manager.dart';
import 'package:dio/dio.dart';
import '../models/utilities/token_api.dart';

class AuthApi {
  final _baseUrl = ServerSettings.baseUrl;
  final _dio = Dio();

  void _refreshTokens() async {
    var response = await _dio.post(
      "$_baseUrl/users/refresh/",
      data: { "refresh": await TokenApi.getRefreshToken() }
    );
    if(response.statusCode == 200) return;

    await TokenApi.setAccessToken(response.data["access"]);
    await TokenApi.setRefreshToken(response.data["refresh"]);
  }

  Future<Response> post(String? relativeUrl, String? accessToken, Map<dynamic, dynamic> data) async {
    var fullUrl = "$_baseUrl$relativeUrl";
    var response = await _dio.post(
      fullUrl,
      queryParameters: { "Authorization": "Bearer $accessToken" },
      data: data
    );
    return response;
  }

  Future<Response> get(String? relativeUrl, String? accessToken) async {
    var fullUrl = "$_baseUrl$relativeUrl";
    var response = await _dio.post(
        fullUrl,
        queryParameters: { "Authorization": "Bearer $accessToken" },
    );
    return response;
  }

  Future<dynamic> getSelfInfo() async {
    var access = await TokenApi.getAccessToken();
    var refresh = await TokenApi.getRefreshToken();

    var response = await get("/users/me/", access);
    while(response.statusCode == 401) {
      _refreshTokens();
      response = await get("/users/me/", access);
    }
    
    return response.data;
  }

}