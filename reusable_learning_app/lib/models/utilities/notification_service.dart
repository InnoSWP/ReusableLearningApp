import 'dart:convert';
import 'package:flutter/material.dart' hide Notification;
import 'package:shared_preferences/shared_preferences.dart';
import '../notification.dart';
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart' ;


class NotificationService {

  static createScheduledNotification(
      String title,
      String description,
      TimeOfDay date,
      {bool repeat = false}
      ) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: "scheduled_channel",
        title: title,
        body: description,
        notificationLayout: NotificationLayout.Default
      ),
      schedule: NotificationCalendar(
        repeats: repeat,
        hour: date.hour,
        minute: date.minute,
        second: 0,
        millisecond: 0,
        allowWhileIdle: true
      )
    );
  }
  static init() async {
    AwesomeNotifications().displayedStream.listen(
    (ReceivedNotification received) {
      TimeOfDay now = TimeOfDay.now();
      setNotification(
        Notification(
          "Notification".tr,
          received.title,
          received.body,
          now.hour,
          now.minute
        )
      );
    });
  }

  static Future<List<Notification>> getAllNotifications() async {

    var instance = await SharedPreferences.getInstance();
    var strList = instance.getStringList("notifications");
    if(strList == null) return [];
    return strList.map((e) => Notification.fromJson(jsonDecode(e))).toList();
  }

  static deleteNotification(int id) async {
    var instance = await SharedPreferences.getInstance();
    var notifications = await getAllNotifications();
    notifications.remove(notifications.firstWhere((element) => element.id == id));
    instance.setStringList("notifications", notifications.map((e) => jsonEncode(e)).toList());
  }

  static setNotification(Notification notification) async {
    var instance = await SharedPreferences.getInstance();
    var strList = instance.getStringList("notifications");

    if(strList != null) {
      strList.add(jsonEncode(notification));
      instance.setStringList("notifications", strList);
    }
    else {
      var newList = [jsonEncode(notification)];
      instance.setStringList("notifications", newList);
    }
  }
}