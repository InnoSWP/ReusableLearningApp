import 'package:flutter/material.dart';
import 'package:reusable_app/models/interfaces/nav_item.dart';

import '../components/drawer_component.dart';
import '../models/utilities/custom_colors.dart';
import 'Content/achievements_body.dart';
import 'Content/courses_body.dart';
import 'Content/search_body.dart';
import 'Content/settings_body.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class BottomMenu extends StatelessWidget {
  final int page;
  final ValueChanged<int>? onChanged;

  const BottomMenu({
    Key? key,
    required this.page,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: page,
      onTap: onChanged,
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


class _HomePageState extends State {
  final Storage _storage = Storage();
  var _page = 0;

  final List<Widget> _navItems = [CoursesBody(), SearchBody(),
    AchievementsBody(), SettingsBody()];

  void initState() {
    super.initState();
    _page = _storage.loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navItems.elementAt(_page),
      appBar: AppBar(
        backgroundColor: CustomColors.purple,
        title: Text((_navItems.elementAt(_page) as NavItem).title, textAlign: TextAlign.center),
        actions: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))),
        ],
      ),
      bottomNavigationBar: BottomMenu(
        page: _page,
        onChanged: (index) { setState(() => _page = index); }
      ),
      drawer: DrawerComponent()
    );
  }

}


class Storage {
  int loadPage() => 0;
}
