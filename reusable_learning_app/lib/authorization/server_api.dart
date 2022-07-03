import 'package:reusable_app/authorization/authorization_manager.dart';
import 'package:reusable_app/models/boost.dart';
import 'package:reusable_app/models/interfaces/ITokenStorage.dart';
import 'package:reusable_app/models/utilities/server_settings.dart';
import 'package:reusable_app/models/utilities/user_info.dart';
import '../models/course.dart';
import '../models/progress/lesson_progress_info.dart';
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

  Future<Response> request(String method, String? relativeUrl, [Map<dynamic, dynamic>? data, bool retry=true]) async {
    try {
      var access = await storage.getAccessToken();
      var fullUrl = "$_baseUrl$relativeUrl";
      var response = await _dio.request(
        fullUrl,
        data: data,
        options: Options(
            method: method.toUpperCase(),
            headers: {
              "Authorization": "Bearer $access"
            }
        ),
      );
      return response;

    } on DioError catch(e) {
      if(e.response == null){
        print(e.message);
        rethrow;
      }
      if (retry && e.response!.statusCode == 401) {
        await refreshTokens();
        return await request(method, relativeUrl, data, false);
      }
      else{
        rethrow;
      }
    }
  }
  Future<Response> post(String? relativeUrl, {Map<dynamic, dynamic>? data}) async {
    return await request("post", relativeUrl, data);
  }
  Future<Response> get(String? relativeUrl) async {
    return await request("get", relativeUrl);
  }
  Future<Response> delete(String? relativeUrl) async {
    return await request("delete", relativeUrl);
  }
  Future<Response> put(String? relativeUrl) async {
    return await request("put", relativeUrl);
  }


  Future<User> getSelfInfo() async {
    var response = await get("/users/me/");
    var user = User.fromMap(response.data);
    UserInfo.me = user;
    return user;
  }
  Future<List<Course>> getCoursesList() async {
    var courseListResponse = await get("/courses/list/");
    int coursesLength = courseListResponse.data.length;
    var coursesProgressList = await get("/progress/");
    List<Course> resultCourses = [];
    for (int i = 0; i < coursesLength; i++) {
      var currentCourseId = courseListResponse.data[i]["id"];
      resultCourses.add(Course.fromCourseAndProgress(
        courseListResponse.data[i],
        coursesProgressList.data[
          coursesProgressList.data.indexWhere((element) => element["id"] == currentCourseId)
        ]
      ));
    }
    return resultCourses;
  }
  // Future<Course> getCourseById(int id) async {
  //   var courseResponse = await get("/courses/$id/");
  //   var courseProgressResponse = await get("/progress/$id/");
  //   return Course.fromCourseAndProgress(courseResponse.data, courseProgressResponse.data);
  // }
  // get progress for course by id
  Future<List<LessonProgressInfo>> getCourseProgressById(int id) async {
    var response = await get("/progress/$id/");
    return (response.data["lessons"] as List<dynamic>)
      .map((e) => LessonProgressInfo.fromMap(e)).toList();
  }
  Future<List<int>> getFavouriteCoursesId() async {
    int id = UserInfo.me!.id;
    var response = await get("/favorites/courses/courses/$id/");
    UserInfo.favouriteCourses = (response.data as List<dynamic>).map((e) => e as int).toList();
    return UserInfo.favouriteCourses!;
  }
  Future<bool> changeFavoriteCourseState(int id) async {
    if(UserInfo.favouriteCourses!.contains(id)) {
      UserInfo.favouriteCourses!.remove(id);
      return await _removeCourseFromFavorite(id);
    }
    else {
      UserInfo.favouriteCourses!.add(id);
      return await _addCourseToFavorite(id);
    }
  }
  Future<bool> _addCourseToFavorite(int id) async {
    try {
      var response = await post(
        "/favorites/courses/add/$id/",
      );
      return response.statusCode == 201;
    }
    catch(e) {
      return false;
    }
  }
  Future<bool> _removeCourseFromFavorite(int id) async {
    try {
      var response = await delete(
        "/favorites/courses/add/$id/",
      );
      return response.statusCode == 204;
    }
    catch(e) {
      return false;
    }
  }
  Future<List<Boost>> getBoostsList() async {
    var response = await get("/points/shop/");
    return (response.data as List<dynamic>).map((e) => Boost.fromMap(e)).toList();
  }
  Future<int> getUserPoints() async {
    var response = await get("/points/");
    return response.data["score"] as int;
  }
  Future<int> getCompletedLessons() async {
    var response = await get("/points/");
    return response.data["lessons_passed"] as int;
  }
  //make request to server to set lesson to in progress
  Future<bool> setLessonInProgress(int courseId, int lessonId) async {
    var response = await post("/progress/$courseId/lesson/$lessonId/");
    return response.statusCode == 201;
  }
  //make request to server to set lesson to completed
  Future<bool> setLessonCompleted(int courseId, int lessonId) async {
    var response = await put("/progress/$courseId/lesson/$lessonId/");
    return response.statusCode == 200;
  }

}