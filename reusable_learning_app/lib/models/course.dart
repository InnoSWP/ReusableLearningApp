import 'dart:collection';

import 'lesson.dart';

class Course {
  late int id;
  late String name;
  late String description;
  late List<Lesson> lessons;

  Course.fromMap(dynamic json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    lessons = (json["lessons"] as List<dynamic>).map((e) => Lesson.fromMap(e)).toList();
  }
}