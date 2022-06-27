import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reusable_app/authorization/authorization_manager.dart';
import 'package:reusable_app/components/card_template.dart';
import 'package:reusable_app/models/token_secure_storage.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';
import 'package:reusable_app/providers/theme_provider.dart';
import '../../locale_string.dart';
import '../../models/interfaces/nav_item.dart';
import '../../main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import '../set_notifications_screen.dart';


class SettingsBody extends StatefulWidget implements NavItem   {
  SettingsBody({Key? key}) : super(key: key);

  @override
  SettingsBodyState createState() => SettingsBodyState();

  @override
  String title = ("Settings".tr);
}

class SettingsBodyState extends State<SettingsBody> {


  late String _amountOfBonuses;
  late bool _isAudioOn;
  late String _dropdownValue;

  @override
  void initState() {
    super.initState();
    _amountOfBonuses = "500";
    // _isNightMode = prefs.getBool('nightMode')!;
    _isAudioOn = prefs.getBool('audioOn')!;
    _dropdownValue = prefs.getString('dropdownValue')!;
  }

  void _exitFromAnAccount() {
    AuthorizationManager(storage: TokenSecureStorage()).logout();
    Navigator.pushNamed(context, "/authorize");
  }

  void _changeAudioMode(bool newValue) {
    setState(() {
      _isAudioOn = newValue;
      prefs.setBool('audioOn', newValue);
    });
  }

  void _goToNotificationsPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NotificationsStateful())
    );
  }

  void _goToSupportPage() {}

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    bool a = true;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
              padding:
              const EdgeInsets.only(left: 7, right: 7, top: 11, bottom: 11),
              child: CardTemplate(
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
                                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
                                      ),
                                    )
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  children:[
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 3),
                                        child: Text("Darlene Robertson",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            )
                                        )
                                    ),
                                    Text(
                                      "Student".tr,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 13
                                      ),
                                    )
                                  ],
                                ),
                              ]),
                              Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: IconButton(
                                      onPressed: _exitFromAnAccount,
                                      icon: const Icon(Icons.exit_to_app)
                                  )
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                _amountOfBonuses,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const Icon(
                                Icons.attach_money_rounded,
                                color: Colors.yellow,
                              )
                            ],
                          )
                        ],
                      )
                  )
              )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7, right: 7, bottom: 11),
            child: CardTemplate(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 17, top: 15, bottom: 15, right: 5
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("General".tr,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.grey
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Night mode".tr,
                            style: const TextStyle(
                                fontSize: 16
                            )
                        ),
                        Switch(
                            value: provider.isDarkMode,
                            activeColor: CustomColors.purpleDark,
                            onChanged: (value) {
                              prefs.setBool("nightMode", value);
                              provider.toggleTheme(value);
                            }
                        )
                      ],
                    ),
                    const Divider(
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 13,
                        color: Colors.grey
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Language".tr,
                                style: const TextStyle(
                                    fontSize: 16
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 13),
                              child: DropdownButton<String>(
                                value: _dropdownValue,
                                elevation: 16,
                                style: const TextStyle(
                                    color: CustomColors.purpleDark
                                ),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),

                                onChanged: (String? value) async {
                                  await prefs.setString('dropdownValue', value!);
                                  _dropdownValue = value;
                                  await Get.updateLocale(stringToLocale[_dropdownValue]!);
                                },
                                items: <String>['English', 'Русский']
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }
                                ).toList(),
                              ),
                            )
                          ],
                        )
                    )
                  ],
                )
              )
            )
          ),
          Padding(
              padding: const EdgeInsets.only(left: 7, right: 7, bottom: 11),
              child: CardTemplate(
                child: TextButton(
                  onPressed: () {  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Audio".tr,
                            style:
                            const TextStyle(fontSize: 16)
                        ),
                        Switch(
                            value: _isAudioOn,
                            activeColor: Theme.of(context).iconTheme.color,
                            onChanged: (value) {
                              _changeAudioMode(value);
                            }
                        )
                      ],
                    ),
                  ),
                ),
              )
          ),
          Padding(
              padding: const EdgeInsets.only(left: 7, right: 7, bottom: 11),
              child: CardTemplate(
                child: TextButton(
                  onPressed: () {
                    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
                      if(!isAllowed) {
                        AwesomeNotifications().requestPermissionToSendNotifications();
                      }

                    });
                    _goToNotificationsPage(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Notifications".tr,
                            style:
                            const TextStyle(
                              fontSize: 16,
                            )
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.keyboard_arrow_right))
                      ],
                    ),
                  ),
                ),
              )
          ),
          Padding(
              padding: const EdgeInsets.only(left: 7, right: 7, bottom: 11),
              child: CardTemplate(
                child: TextButton(
                  onPressed: () {  },
                  child: Padding(
                      padding:
                      const EdgeInsets.only(left:10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Get Support".tr,
                              style:
                              const TextStyle(
                                fontSize: 16,
                              )
                          ),
                          IconButton(
                              onPressed: _goToSupportPage,
                              icon: const Icon(Icons.keyboard_arrow_right)
                          )
                        ],
                      )
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

}
