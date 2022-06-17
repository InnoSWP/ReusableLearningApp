import 'package:flutter/material.dart';
import '../models/utilities/custom_colors.dart';
import '../screens/Content/achievements_body.dart';
import '../screens/Content/courses_body.dart';
import '../screens/Content/search_body.dart';
import '../screens/Content/settings_body.dart';

class BottomMenu extends StatefulWidget {

  static final List<Widget> navItems = [CoursesBody(), SearchBody(),
    AchievementsBody(), SettingsBody()];
  static int curIndex = 0;

  final ValueChanged<int> onTap;
  BottomMenu({Key? key, required this.onTap}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomMenuState();
}


class _BottomMenuState extends State<BottomMenu> {


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: BottomMenu.curIndex,
      onTap: widget.onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: CustomColors.purple,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled, color: Colors.white,), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.white), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.leaderboard, color: Colors.white), label : "Achievements"),
        BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.white), label : "Settings"),
      ],
    );
  }
}
