import 'package:flutter/material.dart';
import 'package:reusable_app/components/bottom_menu.dart';
import 'package:reusable_app/components/custom_app_bar.dart';
import 'package:reusable_app/models/interfaces/nav_item.dart';

class CoursesBody extends StatefulWidget implements NavItem {
  CoursesBody({Key? key}) : super(key: key);

  @override
  CoursesBodyState createState() => CoursesBodyState();

  @override
  String title = "Home";
}

class CoursesBodyState extends State<CoursesBody>  {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("Home")
    );
  }

}
