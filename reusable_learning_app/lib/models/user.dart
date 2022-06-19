import 'course.dart';

class User {
  late int id;
  late String username;
  late String email;
  late List<Course> courseList;

  User.fromMap(dynamic json) {
    id = json["id"];
    username = json["username"];
    email = json["email"];
    courseList = (json["course_list"] as List)
        .map((e) => Course.fromMap(e)).toList();

  }
}