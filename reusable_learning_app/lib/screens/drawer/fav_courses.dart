import 'package:flutter/material.dart';
import 'package:reusable_app/components/scaffold/bottom_menu.dart';
import 'package:reusable_app/components/scaffold/custom_app_bar.dart';
import 'package:reusable_app/models/token_secure_storage.dart';

import '../../authorization/server_api.dart';
import '../../components/course_card.dart';
import '../../models/course.dart';
import 'package:get/get.dart';


class FavCourses extends StatefulWidget {
  const FavCourses({Key? key}) : super(key: key);

  @override
  State<FavCourses> createState() => _FavCoursesState();
}

class _FavCoursesState extends State<FavCourses> {
  late Future<List<Course>> _coursesInfo;
  late Future<List<int>> _favCourses;
  ServerApi serverApi = ServerApi(storage: TokenSecureStorage());

  @override
  void initState() {
    super.initState();
    _coursesInfo = serverApi.getCoursesList();
    _favCourses = _coursesInfo.then((_) {
      return serverApi.getFavouriteCoursesId();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        barTitle: "Favourite Courses".tr,
      ),
      body: FutureBuilder(
          future: Future.wait([
            _coursesInfo,
            _favCourses
          ]),
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: (snapshot.data![0] as List<Course>).length,
                itemBuilder: (context, index) {
                  var isFav = (snapshot.data![1] as List<int>).contains(index + 1);
                  if(isFav) {
                    return CourseCard(
                      course: snapshot.data![0][index],
                      isFav: isFav,
                    );
                  }
                  return const SizedBox(height: 0);
                },
              );
            }
            else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
      bottomNavigationBar: BottomMenu(
        onTap: (value) => BottomMenu.navigateFromOtherPage(context, value)
      ),
    );


  }

}
