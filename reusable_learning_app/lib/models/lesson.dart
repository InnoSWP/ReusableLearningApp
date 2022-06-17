import 'dart:collection';

import 'package:reusable_app/models/course.dart';

class Lesson {
  late String name;
  late String content;
  late int level;

  Lesson.fromMap(dynamic json) {
    name = json["name"];
    name = json["content"];
    level = json["level"];
  }
}