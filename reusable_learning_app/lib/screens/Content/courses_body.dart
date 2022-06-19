import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:reusable_app/authorization/server_api.dart';
import 'package:reusable_app/components/scaffold/bottom_menu.dart';
import 'package:reusable_app/components/course_card.dart';
import 'package:reusable_app/components/scaffold/custom_app_bar.dart';
import 'package:reusable_app/models/interfaces/nav_item.dart';

import '../../models/course.dart';

class CoursesBody extends StatefulWidget implements NavItem {
  CoursesBody({Key? key}) : super(key: key);

  @override
  CoursesBodyState createState() => CoursesBodyState();

  @override
  String title = "Home";
}

class CoursesBodyState extends State<CoursesBody>  {
  late Future<List<Course>> _coursesInfo;

  @override
  deactivate(){

  }
  @override
  void initState() {
    super.initState();
    _coursesInfo = ServerApi().getCoursesList();
  }

  Future coursesFuture = ServerApi().getCoursesList();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _coursesInfo,
      builder: (context, AsyncSnapshot<List<Course>> snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return CourseCard(course: snapshot.data![index]);
            },
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );


  }

}
