import 'package:flutter/material.dart';

import '../../models/interfaces/nav_item.dart';

class SettingsBody extends StatefulWidget implements NavItem   {
  SettingsBody({Key? key}) : super(key: key);

  @override
  SettingsBodyState createState() => SettingsBodyState();

  @override
  String title = "Settings";
}

class SettingsBodyState extends State<SettingsBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
          child: Text("Settings page")
      ),
    );
  }

}
