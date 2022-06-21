import 'package:reusable_app/models/utilities/server_settings.dart';
import 'package:reusable_app/models/utilities/user_info.dart';
import '../models/course.dart';
import '../models/user.dart';
import 'package:dio/dio.dart';
import '../models/utilities/token_api.dart';

class ServerApi {
  final _baseUrl = ServerSettings.baseUrl;
  final _dio = Dio();

  Future<Response> post(String? relativeUrl, Map<dynamic, dynamic> data) async {
    await TokenApi.refreshTokens();
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
    await TokenApi.refreshTokens();
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
    try {
      int id = UserInfo.me!.id;
      var response = await get("/favorites/courses/courses/$id/");
      UserInfo.favouriteCourses = (response.data as List<dynamic>).map((e) => e as int).toList();
      return UserInfo.favouriteCourses!;
    }
    on DioError catch (e) {
      print("haha");
      return [53453453];
    }

  }
}