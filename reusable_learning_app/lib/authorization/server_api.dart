import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reusable_app/models/utilities/server_settings.dart';
import '../models/course.dart';
import 'authorization_manager.dart';
import 'package:dio/dio.dart';
import '../models/utilities/token_api.dart';

class ServerApi {
  final _baseUrl = ServerSettings.baseUrl;
  final _dio = Dio();

  Future<Response> post(String? relativeUrl, Map<dynamic, dynamic> data) async {
    TokenApi.refreshTokens();
    var access = await TokenApi.getAccessToken();
    var fullUrl = "$_baseUrl$relativeUrl";
    var response = await _dio.post(
      fullUrl,
      queryParameters: { "Authorization": "Bearer $access" },
      data: data
    );
    return response;
  }

  Future<Response> get(String? relativeUrl) async {
    TokenApi.refreshTokens();
    var response;
    var access = await TokenApi.getAccessToken();
    var fullUrl = "$_baseUrl$relativeUrl";
    try {
      response = await _dio.get(
        fullUrl,
        options: Options(
          headers: {"Authorization": "Bearer $access"}
        )
      );
    }
    on DioError catch(e) {
      print(e.message);
    }
    return response;
  }

  Future<dynamic> getSelfInfo() async {
    var response = await get("/users/me/");

    return response.data;
  }
  Future<List<Course>> getCoursesList() async {
    var response = await get("/courses/list/");

    return (response.data as List<dynamic>).map((e) => Course.fromMap(e)).toList();
  }

}