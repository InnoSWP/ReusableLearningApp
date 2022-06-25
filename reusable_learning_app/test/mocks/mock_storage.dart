import 'package:reusable_app/models/interfaces/ITokenStorage.dart';

class MockStorage implements ITokenStorage {

  static String? accessToken;
  static String? refreshToken;

  @override
  Future<String?> getAccessToken() async {
    return accessToken;
  }
  @override
  Future<String?> getRefreshToken() async {
    return refreshToken;
  }

  @override
  Future setAccessToken(String? access) async {
    accessToken = access;
  }

  @override
  Future setRefreshToken(String? refresh) async {
    refreshToken = refresh;
  }

}