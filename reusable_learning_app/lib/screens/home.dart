import 'package:flutter/material.dart';

import '../models/custom_colors.dart';
import 'Content/AchievementsBody.dart';
import 'Content/HomeBody.dart';
import 'Content/SearchBody.dart';
import 'Content/SettingsBody.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
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
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded, color: Colors.white), label : "Achievements"),
        BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.white), label : "Settings"),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Storage _storage = Storage();
  var _page = 0;

  @override
  void initState() {
    super.initState();
    _page = _storage.loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyPage(_page),
      bottomNavigationBar: BottomMenu(
        page: _page,
        onChanged: onChanged,
      ),
    );
  }

  void onChanged(int index) => setState(() => _page = index);


  Widget _bodyPage(int page) {
    switch (page) {
      case 0:
        return const HomeBody();
      case 1:
        return const SearchBody();
      case 2:
        return const AchievementsBody();
      case 3:
        return const SettingsBody();
    }
    throw Exception('Unknown page');
  }
}


class Storage {
  int loadPage() => 0;
}
