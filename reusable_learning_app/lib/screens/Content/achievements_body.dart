import 'package:flutter/material.dart';
import 'package:reusable_app/models/interfaces/nav_item.dart';

class AchievementsBody extends StatefulWidget implements NavItem {
  AchievementsBody({Key? key}) : super(key: key);

  @override
  AchievementsBodyState createState() => AchievementsBodyState();

  @override
  String title = "Achivements";
}

class AchievementsBodyState extends State<AchievementsBody>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Achievements page"),
    );
  }
}
