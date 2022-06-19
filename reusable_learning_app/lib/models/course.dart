import 'dart:collection';

import 'lesson.dart';

class Course {
  late String name;
  late String description;
  late List<Lesson> lessons;

  Course.fromMap(dynamic json) {
    name = json["name"];
    description = json["description"];
    lessons = (json["lessons"] as List<dynamic>).map((e) => Lesson.fromMap(e)).toList();
  }
}