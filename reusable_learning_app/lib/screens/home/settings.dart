import 'package:flutter/material.dart';

import '../../models/interfaces/NavBarItem.dart';

class Settings extends StatefulWidget implements NavBarItem {
  Settings({Key? key}) : super(key: key);

  @override
  String? title = "Settings";

  @override
  State<StatefulWidget> createState() => _SettingsState();
}
class _SettingsState extends State {
  @override
  Widget build(BuildContext context ) {
    return Center(child: Text("Settings"));
  }
}