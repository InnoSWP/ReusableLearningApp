import 'package:flutter/material.dart';
import 'package:reusable_app/models/interfaces/NavBarItem.dart';

class Achievements extends StatefulWidget implements NavBarItem {
  Achievements({Key? key}) : super(key: key);
  @override
  String? title = "Achievements";
  @override
  State<StatefulWidget> createState() => _AchievementsState();
}
class _AchievementsState extends State {
  @override
  Widget build(BuildContext context ) {
    return Center(child: Text("Achievements"));
  }
}