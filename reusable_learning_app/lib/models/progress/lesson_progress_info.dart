class LessonProgressInfo {
  int? lessonId;
  String? status;
  // from json
  LessonProgressInfo.fromMap(dynamic json) {
    lessonId = json["lesson"];
    status = json["status"];
  }
}