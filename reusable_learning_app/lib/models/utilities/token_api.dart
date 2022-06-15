import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:reusable_app/models/utilities/server_settings.dart';

class TokenApi {
  static const _storage = FlutterSecureStorage();
  static final _dio = Dio();

  static getRefreshToken() async {
    return await _storage.read(key: "jwtRefresh");
  }
  static getAccessToken() async {
    return await _storage.read(key: "jwtAccess");
  }
  static setRefreshToken(String? newToken) async {
    await _storage.write(key: "jwtRefresh", value: newToken);
  }
  static setAccessToken(String? newToken) async {
    await _storage.write(key: "jwtAccess", value: newToken);
  }
  static refreshTokens() async {
    var response = await _dio.post(
        "${ServerSettings.baseUrl}/users/refresh/",
        data: { "refresh": await TokenApi.getRefreshToken() }
    );
    if(response.statusCode != 200) return;

    await TokenApi.setAccessToken(response.data["access"]);
    await TokenApi.setRefreshToken(response.data["refresh"]);
  }
}