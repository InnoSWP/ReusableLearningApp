import 'dart:collection';

import 'package:reusable_app/models/progress/lesson_progress_info.dart';

import 'lesson.dart';

class Course {
  late int id;
  late String name;
  late String description;
  late List<Lesson> lessons;
  late double? totalCourseProgress;
  late List<LessonProgressInfo>? lessonProgressInfoList;


  Course.fromCourseAndProgress(dynamic course, dynamic progress) {
    id = course["id"];
    name = course["name"];
    description = course["description"];
    lessons = (course["lessons"] as List<dynamic>).map((e) => Lesson.fromMap(e)).toList();
    totalCourseProgress = progress["progress"];
    lessonProgressInfoList = (progress["lessons"] as List<dynamic>)
        .map((e) => LessonProgressInfo.fromMap(e)).toList();
  }
}