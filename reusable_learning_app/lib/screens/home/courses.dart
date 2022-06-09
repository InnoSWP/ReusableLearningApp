import 'package:flutter/material.dart';

import '../../authorization/authorization_manager.dart';
import '../../models/interfaces/NavBarItem.dart';

class Courses extends StatefulWidget implements NavBarItem {
  Courses({Key? key}) : super(key: key);
  @override
  String? title = "Courses";

  @override
  State<StatefulWidget> createState() => _CoursesState();
}
class _CoursesState extends State {
  @override
  Widget build(BuildContext context ) {
    return Center(
      child: Text("Courses"),
    );
  }
}