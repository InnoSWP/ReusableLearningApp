import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reusable_app/models/utilities/server_settings.dart';
import 'authorization_manager.dart';
import 'package:dio/dio.dart';
import '../models/utilities/token_api.dart';

class ServerApi {
  final _baseUrl = ServerSettings.baseUrl;
  final _dio = Dio();

  Future<Response> post(String? relativeUrl, String? accessToken, Map<dynamic, dynamic> data) async {
    TokenApi.refreshTokens();

    var fullUrl = "$_baseUrl$relativeUrl";
    var response = await _dio.post(
      fullUrl,
      queryParameters: { "Authorization": "Bearer $accessToken" },
      data: data
    );
    return response;
  }

  Future<Response> get(String? relativeUrl, String? accessToken) async {
    TokenApi.refreshTokens();
    var response;
    var fullUrl = "$_baseUrl$relativeUrl";
    try {
      response = await _dio.get(
        fullUrl,
        options: Options(
          headers: {"Authorization": "Bearer $accessToken"}
        )
      );
    }
    on DioError catch(e) {
      print(e.message);
    }
    return response;
  }

  Future<dynamic> getSelfInfo() async {

    var access = await TokenApi.getAccessToken();
    var refresh = await TokenApi.getRefreshToken();

    var response = await get("/users/me/", access);
    return response.data;
  }

}