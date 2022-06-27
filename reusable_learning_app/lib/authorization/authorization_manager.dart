import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:reusable_app/authorization/server_api.dart';
import 'package:reusable_app/models/interfaces/ITokenStorage.dart';
import 'package:reusable_app/models/utilities/server_settings.dart';
import 'package:reusable_app/models/token_secure_storage.dart';


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

  late final ITokenStorage storage;
  late final ServerApi serverApi;

  AuthorizationManager({required this.storage}) {
    serverApi = ServerApi(storage: storage);
  }



  Future<AuthResult> authorize(String username, String password) async {
    // check for authorization
    var data = {"username": username, "password": password};
    var response;
    try {
      response = await _dio.post("${ServerSettings.baseUrl}/users/login/",
          data: data, queryParameters: {"Content-Type": "application/json"});
    } on DioError catch (e) {
      if (e.response == null) {
        return AuthResult()..errorMessage = "Connection to server lost.".tr;
      }
      if (e.response!.statusCode == 401) {
        return AuthResult()
          ..errorMessage = "No active account found with the given credentials".tr;
      }
      if (e.response!.statusCode == 400) {
        return AuthResult()
          ..errorMessage = "Bad Request".tr;
      }
      else {
        return AuthResult()
        ..errorMessage = "Mysterious error happened".tr;
      }
    }

    await storage.setRefreshToken(response!.data["refresh"]);
    await storage.setAccessToken(response!.data["access"]);

    return AuthResult()..isAuthorized = true;
  }

  Future<bool> isAuthorized() async {
    await serverApi.refreshTokens();

    String? refreshToken = await storage.getRefreshToken();
    String? accessToken = await storage.getAccessToken();

    if (refreshToken == null || accessToken == null) {
      return false;
    }
    return true;
  }

  Future<AccountCreateResult> registerAccount(
      String email, String username, String password) async {
    var data = {"email": email, "username": username, "password": password};
    var response;
    try {
      response = await _dio.post("${ServerSettings.baseUrl}/users/register/",
          queryParameters: {"Content-Type": "application/json"}, data: data);
    } on DioError catch (e) {
      if (e.response == null) {
        return AccountCreateResult()
          ..errorMessage = "Connection to server lost.".tr;
      }
      if (e.response!.statusCode == 400) {
        return AccountCreateResult()
          ..errorMessage = "A user with that username already exists.".tr;
      }
    }
    if (response == null) {
      return AccountCreateResult()..errorMessage = "Some error happened".tr;
    }

    await storage.setRefreshToken(response.data["refresh"]);
    await storage.setAccessToken(response.data["access"]);

    return AccountCreateResult()..isCreated = true;
  }

  void logout() {
    storage.setAccessToken(null);
    storage.setRefreshToken(null);
  }
}
