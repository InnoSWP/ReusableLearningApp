import 'package:reusable_app/authorization/authorization_manager.dart';
import 'package:reusable_app/models/interfaces/ITokenStorage.dart';
import 'package:reusable_app/models/utilities/server_settings.dart';
import 'package:reusable_app/models/utilities/user_info.dart';
import '../models/course.dart';
import '../models/user.dart';
import 'package:dio/dio.dart';
import '../models/token_secure_storage.dart';

class ServerApi {
  final _baseUrl = ServerSettings.baseUrl;
  final _dio = Dio();
  late ITokenStorage storage;

  ServerApi({required this.storage});

  Future refreshTokens() async {
    var token = await storage.getRefreshToken();
    if (token == null) return;
    var response = await _dio.post(
        "${ServerSettings.baseUrl}/users/refresh/",
        data: { "refresh": token }
    );
    if(response.statusCode != 200) return;

    await storage.setAccessToken(response.data["access"]);
    await storage.setRefreshToken(response.data["refresh"]);
  }

  Future<Response> post(String? relativeUrl, {Map<dynamic, dynamic>? data}) async {
    await refreshTokens();
    var access = await storage.getAccessToken();
    var fullUrl = "$_baseUrl$relativeUrl";
    var response = await _dio.post(
      fullUrl,
      queryParameters: { "Authorization": "Bearer $access" },
      data: data
    );
    return response;
  }

  Future<Response> get(String? relativeUrl) async {
    await refreshTokens();
    var response;
    var access = await storage.getAccessToken();
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
  Future<Response> delete(String? relativeUrl) async {
    await refreshTokens();
    var response;
    var access = await storage.getAccessToken();
    var fullUrl = "$_baseUrl$relativeUrl";
    try {
      response = await _dio.delete(
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
  Future<User> getSelfInfo() async {
    var response = await get("/users/me/");
    var user = User.fromMap(response.data);
    UserInfo.me = user;
    return user;
  }
  Future<List<Course>> getCoursesList() async {
    var response = await get("/courses/list/");

    return (response.data as List<dynamic>).map((e) => Course.fromMap(e)).toList();
  }
  Future<List<int>> getFavouriteCoursesId() async {
    int id = UserInfo.me!.id;
    var response = await get("/favorites/courses/courses/$id/");
    UserInfo.favouriteCourses = (response.data as List<dynamic>).map((e) => e as int).toList();
    return UserInfo.favouriteCourses!;
  }

  changeFavoriteCourseState(int id) {
    if(UserInfo.favouriteCourses!.contains(id)) {
      _removeCourseFromFavorite(id);
      UserInfo.favouriteCourses!.remove(id);
    }
    else {
      _addCourseToFavorite(id);
      UserInfo.favouriteCourses!.add(id);
    }
  }

  _addCourseToFavorite(int id) async {
    var response = await post(
      "/favorites/courses/add/$id/",
    );
  }
  _removeCourseFromFavorite(int id) async {
    var response = await delete(
      "/favorites/courses/add/$id/",
    );
  }
}