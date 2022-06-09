import 'course.dart';

abstract class User {
  int? id;
  String? username;
  String? email;
  List<Course>? courseList;
}