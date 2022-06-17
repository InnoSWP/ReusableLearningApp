import 'package:flutter/material.dart';
import 'package:reusable_app/authorization/server_api.dart';
import 'package:reusable_app/components/bottom_menu.dart';
import 'package:reusable_app/components/course_card.dart';
import 'package:reusable_app/components/custom_app_bar.dart';
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
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return CourseCard(course: snapshot.data![index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 20);
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
