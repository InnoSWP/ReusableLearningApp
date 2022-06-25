import 'dart:ffi';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:reusable_app/models/interfaces/ITokenStorage.dart';
import 'package:reusable_app/models/utilities/server_settings.dart';

class TokenSecureStorage implements ITokenStorage {
  static const _storage = FlutterSecureStorage();
  static final _dio = Dio();

  setAllTokens({required String access, required String refresh}) async {
    await _storage.write(key: "jwtRefresh", value: refresh);
    await _storage.write(key: "jwtAccess", value: access);
  }
  @override
  getRefreshToken() async {
    return await _storage.read(key: "jwtRefresh");
  }
  @override
  getAccessToken() async {
    return await _storage.read(key: "jwtAccess");
  }
  setRefreshToken(String? newToken) async {
    await _storage.write(key: "jwtRefresh", value: newToken);
  }
  setAccessToken(String? newToken) async {
    await _storage.write(key: "jwtAccess", value: newToken);
  }

}