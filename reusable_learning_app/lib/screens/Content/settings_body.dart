import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../locale_string.dart';
import '../../models/interfaces/nav_item.dart';

class SettingsBody extends StatefulWidget implements NavItem   {
  SettingsBody({Key? key}) : super(key: key);

  @override
  SettingsBodyState createState() => SettingsBodyState();

  @override
  String title = ("Settings".tr);
}


String _amountOfBonuses = "500";
bool _isNightMode = false;
bool _isAudioOn = false;
String _dropdownValue = "English";

class SettingsBodyState extends State<SettingsBody> {
  @override
  void initState() {
    super.initState();
  }

  void _exitFromAnAccount() {}

  void _changeNightMode(bool newValue) {
    setState(() {
      _isNightMode = newValue;
    });
  }

  void _changeAudioMode(bool newValue) {
    setState(() {
      _isAudioOn = newValue;
    });
  }

  void _goToNotificationsPage() {}

  void _goToSupportPage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.only(left: 7, right: 7, top: 11, bottom: 11),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(left: 17, top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: CircleAvatar(
                                      radius: 20, // Image radius
                                      backgroundImage: NetworkImage(
                                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                                    )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  children:[
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 3),
                                        child: Text("Darlene Robertson",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold))),
                                    Text(
                                      "Student".tr,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    )
                                  ],
                                ),
                              ]),
                              Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: IconButton(
                                      onPressed: _exitFromAnAccount,
                                      icon: const Icon(Icons.exit_to_app)))
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                _amountOfBonuses,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.attach_money_rounded,
                                color: Colors.yellow,
                              )
                            ],
                          )
                        ],
                      )))) // Name, Surname
          ,
          Padding(
              padding: const EdgeInsets.only(left: 7, right: 7, bottom: 11),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 17, top: 15, bottom: 15, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("General".tr,
                              style:
                                  const TextStyle(fontSize: 16, color: Colors.grey)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Night mode".tr,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black)),
                              Switch(
                                  value: _isNightMode,
                                  activeColor: Colors.deepPurple,
                                  onChanged: (value) {
                                    _changeNightMode(value);
                                  })
                            ],
                          ),
                          const Divider(
                              height: 5,
                              thickness: 1,
                              indent: 0,
                              endIndent: 13,
                              color: Colors.grey),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Language".tr,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black)),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 13),
                                    child: DropdownButton<String>(
                                      value: _dropdownValue,
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: Colors.deepPurple),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _dropdownValue = newValue!;
                                          Get.updateLocale(stringToLocale[_dropdownValue]!);
                                        });
                                      },
                                      items: <String>['English', 'Русский']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      )))) // General
          ,
          Padding(
              padding: const EdgeInsets.only(left: 7, right: 7, bottom: 11),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 17, top: 5, bottom: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Audio".tr,
                            style:
                                const TextStyle(fontSize: 16, color: Colors.black)),
                        Switch(
                            value: _isAudioOn,
                            activeColor: Colors.deepPurple,
                            onChanged: (value) {
                              _changeAudioMode(value);
                            })
                      ],
                    ),
                  ))) // Audio
          ,
          Padding(
              padding: const EdgeInsets.only(left: 7, right: 7, bottom: 11),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Notifications".tr,
                            style:
                                const TextStyle(fontSize: 16, color: Colors.black)),
                        IconButton(
                            onPressed: _goToNotificationsPage,
                            icon: const Icon(Icons.keyboard_arrow_right))
                      ],
                    ),
                  ))) // Notifications
          ,
          Padding(
              padding: const EdgeInsets.only(left: 7, right: 7, bottom: 11),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(left: 17, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Get Support".tr,
                              style:
                                  const TextStyle(fontSize: 16, color: Colors.black)),
                          IconButton(
                              onPressed: _goToSupportPage,
                              icon: const Icon(Icons.keyboard_arrow_right))
                        ],
                      )))) // Get support
          ,
        ],
      ),
    );
  }

}
