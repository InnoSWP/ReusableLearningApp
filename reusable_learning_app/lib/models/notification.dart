import 'package:flutter/material.dart';

class Notification{
  int id = UniqueKey().hashCode;
  String? title;
  String? subTitle;
  String? body;
  int? hour;
  int? minute;

  Notification(this.title, this.subTitle, this.body, this.hour, this.minute);

  String get time {
    var result = '';
    if (hour! < 10) {
      result += "0$hour";
    }
    else {
      result += "$hour";
    }
    result += ":";
    if (minute! < 10) {
      result += "0$minute";
    }
    else {
      result += "$minute";
    }
    return result;
  }

  Notification.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    subTitle = json["subTitle"];
    body = json["body"];
    hour = json["hour"];
    minute = json["minute"];
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subTitle": subTitle,
    "body": body,
    "hour": hour,
    "minute": minute
  };
}

