import 'package:flutter/material.dart';
import '../../models/utilities/custom_colors.dart';
import '../../screens/Content/achievements_body.dart';
import '../../screens/Content/courses_body.dart';
import '../../screens/Content/shop_body.dart';
import '../../screens/Content/settings_body.dart';
import '../../screens/home.dart';

class BottomMenu extends StatefulWidget {

  static final List<Widget> navItems = [CoursesBody(), ShopBody(),
    AchievementsBody(), SettingsBody()];
  static int curIndex = 0;

  static void defaultNavigate(BuildContext context, int index){
    BottomMenu.curIndex = index;
  }
  static void navigateFromOtherPage(BuildContext context, int index){
    Navigator.push(
        context,
        PageRouteBuilder(pageBuilder: (context, _, __) {
          return Home(startIndex: index);
        })
    );
    BottomMenu.curIndex = index;
  }

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
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, color: Colors.white), label: 'Shop'),
        BottomNavigationBarItem(icon: Icon(Icons.leaderboard, color: Colors.white), label : "Achievements"),
        BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.white), label : "Settings"),
      ],
    );
  }
}
