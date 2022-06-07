import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthorizationManager {
  final storage = const FlutterSecureStorage();
  final dio = Dio();

  void authorize(String username, String password) async {
    // check for authorization
    if (await isAuthorized()) return;

    var response = await dio.post(
      "future api link)))",
      data: { "username": username, "password": password }
    );

    if (response.statusCode != 200) return;

    await storage.write(key: 'jwtRefresh', value: response.data["refresh"]);
    await storage.write(key: 'jwtAccess', value: response.data["access"]);
  }
  Future<bool> isAuthorized() async {
    //TODO
    return false;
  }
  void logout() {
    storage.write(key: 'jwtRefresh', value: null);
    storage.write(key: 'jwtAccess', value: null);
  }
}