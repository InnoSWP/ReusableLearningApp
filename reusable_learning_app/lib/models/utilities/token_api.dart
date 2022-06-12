import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenApi {
  static const _storage = FlutterSecureStorage();

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
}