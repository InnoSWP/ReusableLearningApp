import 'package:reusable_app/models/lesson.dart';

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
  }
}