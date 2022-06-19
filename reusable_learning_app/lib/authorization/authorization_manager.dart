import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reusable_app/models/utilities/server_settings.dart';
import 'package:reusable_app/models/utilities/token_api.dart';

class AuthResult {
  bool isAuthorized = false;
  String? errorMessage;
}
class AccountCreateResult {
  bool isCreated = false;
  String? errorMessage;
}

class AuthorizationManager {
  final _dio = Dio();

  Future<AuthResult> authorize(String username, String password) async {
    // check for authorization
    var data = {
      "username": username,
      "password": password
    };
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
      if(e.response == null) return AuthResult()..errorMessage = "Connection to server lost.";
      if (e.response!.statusCode == 401) {
        return AuthResult()..errorMessage = "No active account found with the given credentials";
      }
    }

    await TokenApi.setRefreshToken(response!.data["refresh"]);
    await TokenApi.setAccessToken(response.data["access"]);

    return AuthResult()..isAuthorized = true;
  }
  Future<bool> isAuthorized() async {
    await TokenApi.refreshTokens();

    String? refreshToken = await TokenApi.getRefreshToken();
    String? accessToken = await TokenApi.getAccessToken();

    if (refreshToken == null || accessToken == null) {
      return false;
    }
    return true;
  }
  Future<AccountCreateResult> registerAccount(String email, String username, String password) async {
    var data = {
      "email": email,
      "username": username,
      "password": password
    };
    Response? response;
    try {
      response = await _dio.post(
        "${ServerSettings.baseUrl}/users/register/",
        queryParameters: {
          "Content-Type": "application/json"
        },
        data: data
      );
    }
    on DioError catch (e) {
      if(e.response == null) return AccountCreateResult()..errorMessage = "Connection to server lost.";
      if (e.response!.statusCode == 400) {
        return AccountCreateResult()..errorMessage = "A user with that username already exists.";
      }
    }
    if (response == null) {
      return AccountCreateResult()..errorMessage = "Some error happened";
    }

    await TokenApi.setRefreshToken(response.data["refresh"]);
    await TokenApi.setAccessToken(response.data["access"]);

    return AccountCreateResult()..isCreated = true;
  }
  void logout() {
    TokenApi.setAccessToken(null);
    TokenApi.setRefreshToken(null);
  }
}