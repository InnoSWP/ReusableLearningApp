
import 'package:flutter/material.dart';
import 'package:reusable_app/authorization/server_api.dart';
import 'package:reusable_app/components/scaffold/bottom_menu.dart';
import 'package:reusable_app/components/course_card.dart';
import 'package:reusable_app/components/scaffold/custom_app_bar.dart';
import 'package:reusable_app/models/interfaces/nav_item.dart';
import 'package:reusable_app/models/utilities/user_info.dart';

import '../../models/course.dart';
import '../../models/user.dart';

class CoursesBody extends StatefulWidget implements NavItem {
  CoursesBody({Key? key}) : super(key: key);

  @override
  CoursesBodyState createState() => CoursesBodyState();

  @override
  String title = "Home";
}

class CoursesBodyState extends State<CoursesBody>  {
  late Future<List<Course>> _coursesInfo;
  late Future<List<int>> _favCourses;
  late Future<User> _user;
  ServerApi serverApi = ServerApi();

  @override
  void initState() {
    super.initState();
    _user = serverApi.getSelfInfo();
    _coursesInfo = _user.then((_) {
      return serverApi.getCoursesList();
    });
    _favCourses = _coursesInfo.then((_) {
      return serverApi.getFavouriteCoursesId();
    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _user,
        _coursesInfo,
        _favCourses
      ]),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: (snapshot.data![1] as List<Course>).length,
            itemBuilder: (context, index) {
              return CourseCard(
                course: snapshot.data![1][index],
                isFav: (snapshot.data![2] as List<int>).contains(index + 1),
              );
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
