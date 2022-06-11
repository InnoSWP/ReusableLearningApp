import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reusable_app/models/utilities/server_settings.dart';
import 'package:reusable_app/models/utilities/token_api.dart';

class Result {
  bool isAuthorized = false;
  String? errorMessage;
}

class AuthorizationManager {
  final _dio = Dio();

  Future<Result> authorize(String username, String password) async {
    // check for authorization
    
    var data = {
      "username": username,
      "password": password
    };
    print(jsonEncode(data));
    Response? response;
    try {
      response = await _dio.post(
        "${ServerSettings.baseUrl}/users/login/",
        data: data,
        queryParameters: {
          "Content-Type": "application/json"
        }
      );
    }
    on DioError catch (e) {
      print(e.message);
    }
    if(response == null) return Result()..errorMessage = "Some error happened";

    await TokenApi.setRefreshToken(response.data["refresh"]);
    await TokenApi.setAccessToken(response.data["access"]);

    return Result()..isAuthorized = true;
  }
  Future<bool> isAuthorized() async {
    String? refreshToken = await TokenApi.getRefreshToken();
    String? accessToken = await TokenApi.getAccessToken();

    if (refreshToken == null || accessToken == null) {
      return false;
    }
    return true;
  }
  void logout() {
    TokenApi.setAccessToken(null);
    TokenApi.setRefreshToken(null);
  }
}