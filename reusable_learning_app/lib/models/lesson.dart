import 'dart:collection';

import 'package:reusable_app/models/course.dart';

class Lesson {
  late int id;
  late String name;
  late String content;
  late int level;

  Lesson.fromMap(dynamic json) {
    id = json["id"];
    name = json["name"];
    content = json["content"];
    level = json["level"];
  }
}