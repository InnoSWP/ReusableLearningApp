import 'package:flutter/material.dart';
import 'package:reusable_app/components/custom_app_bar.dart';
import 'package:reusable_app/models/interfaces/nav_item.dart';

import '../components/bottom_menu.dart';
import '../components/drawer_component.dart';
import '../models/utilities/custom_colors.dart';
import 'Content/achievements_body.dart';
import 'Content/courses_body.dart';
import 'Content/search_body.dart';
import 'Content/settings_body.dart';

class Home extends StatefulWidget {
  int startIndex;

  Home({Key? key, this.startIndex = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {

  void initState() {
    super.initState();
    BottomMenu.curIndex = widget.startIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomMenu.navItems.elementAt(BottomMenu.curIndex),
      appBar: CustomAppBar(
        barTitle: (BottomMenu.navItems.elementAt(BottomMenu.curIndex) as NavItem).title,
        backButton: false,
      ),
      bottomNavigationBar: BottomMenu(
        onTap: (value) => setState(() { BottomMenu.defaultNavigate(context, value); }),
      ),
      drawer: const DrawerComponent()
    );
  }

}

