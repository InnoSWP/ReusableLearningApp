import 'package:flutter/material.dart';
import 'package:reusable_app/authorization/server_api.dart';
import 'package:reusable_app/components/scaffold/bottom_menu.dart';
import 'package:reusable_app/components/course_card.dart';
import 'package:reusable_app/components/scaffold/custom_app_bar.dart';
import 'package:reusable_app/models/interfaces/nav_item.dart';
import 'package:reusable_app/models/utilities/user_info.dart';
import 'package:get/get.dart';
import '../../models/course.dart';
import '../../models/token_secure_storage.dart';
import '../../models/user.dart';

class CoursesBody extends StatefulWidget implements NavItem {
  CoursesBody({Key? key}) : super(key: key);

  @override
  CoursesBodyState createState() => CoursesBodyState();

  @override
  String title = ("Home".tr);
}

class CoursesBodyState extends State<CoursesBody> {

  ServerApi serverApi = ServerApi(storage: TokenSecureStorage());

  @override
  void initState() {
    super.initState();

  }

  bool _match(String name, String search) {
    List<String> tokens = name.toLowerCase().split(" ");
    for (String token in tokens) {
      if (token.startsWith(search)) {
        return true;
      }
    }
    return false;
  }

  String searchString = "";

  @override
  Widget build(BuildContext context) {
    var user = serverApi.getSelfInfo();
    var coursesInfo = user.then((_) {
      return serverApi.getCoursesList();
    });
    var favCourses = coursesInfo.then((_) {
      return serverApi.getFavouriteCoursesId();
    });

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchString = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              labelText: 'Search'.tr,
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: FutureBuilder(
            future: Future.wait([user, coursesInfo, favCourses]),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: (snapshot.data![1] as List<Course>).length,
                  itemBuilder: (context, index) {
                    return _match(snapshot.data![1][index].name, searchString)
                        ? CourseCard(
                            stateCallback: () {
                              setState(() {});
                            },
                            course: snapshot.data![1][index],
                            isFav: (snapshot.data![2] as List<int>).contains(
                                (snapshot.data![1] as List<Course>)[index].id),
                          )
                        : Container();
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
