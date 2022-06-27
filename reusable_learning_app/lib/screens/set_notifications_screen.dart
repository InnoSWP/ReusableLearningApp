import 'package:flutter/material.dart' hide Notification;
import 'package:reusable_app/components/card_template.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';
import 'package:awesome_notifications/awesome_notifications.dart' hide Notification;
import 'package:reusable_app/models/utilities/notification_service.dart';

import '../models/notification.dart';
import '../models/utilities/notification_sender.dart';


class NotificationsStateful extends StatefulWidget {
  NotificationsStateful({Key? key}) : super(key: key);

  @override
  State<NotificationsStateful> createState() => Notifications();
}

class Notifications extends State<NotificationsStateful> {
  TextEditingController editingController = TextEditingController();
  late bool _isReminderEnabled;
  late String message;
  late TimeOfDay selectedTime;

  @override
  initState() {
    _isReminderEnabled = false;
    message = "Hey! It is time to learn!";
    selectedTime = TimeOfDay.now();
  }
  void _onSubmit(BuildContext context) {
    NotificationService.createScheduledNotification(
        "New Notification!",
        message,
        selectedTime,
        repeat: _isReminderEnabled
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // backgroundColor: Theme.of(context).backgroundColor,
        content: Text(
          'Notification has been created!',
          // style: Theme.of(context).snackBarTheme.contentTextStyle,
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),

      )
    );
  }

  void _changeReminderState(bool newState) {
    setState(() {
      _isReminderEnabled = newState;
    });
  }
  void _updateMessage(String newMessage) {
    setState(() {
      message = newMessage;
    });
  }
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text("Notifications"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 7, right: 7, top: 11, bottom: 11),
        child: CardTemplate(
          child: Padding(
            padding: const EdgeInsets.only(left: 17, top: 11, bottom: 15, right: 5),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Enable daily reminder",
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                    value: _isReminderEnabled,
                    activeColor: Theme.of(context).textTheme.titleSmall!.color,
                    onChanged: (value) {
                      _changeReminderState(value);
                    }
                  )
                ],
              ),
              const Divider(
                  height: 5,
                  thickness: 1,
                  indent: 0,
                  endIndent: 13,
                  color: Colors.grey),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).textTheme.titleSmall!.backgroundColor)),
                      onPressed: () {
                        _selectTime(context);
                      },
                      child: const Text(
                        "Select Time",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        )
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).textTheme.titleSmall!.backgroundColor)),
                      onPressed: () {
                        _onSubmit(context);
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        )
                      ),
                    ),
                    Text(
                      "${selectedTime.hour}:${selectedTime.minute}",
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    )
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(right: 18),
                        child: Text("Input message:",
                            style: TextStyle(fontSize: 16))),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          _updateMessage(value);
                        },
                        controller: editingController,
                        decoration: const InputDecoration(
                          hintText: "Hey! It is time to learn!",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5.0))),
                          focusColor: CustomColors.purple,
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ])
          )
        )
      )
    );
  }


}