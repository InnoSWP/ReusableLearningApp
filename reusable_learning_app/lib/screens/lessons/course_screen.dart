import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reusable_app/components/courses_components/lesson_listview_item.dart';
import 'package:reusable_app/components/scaffold/bottom_menu.dart';
import 'package:reusable_app/components/card_template.dart';
import 'package:get/get.dart';


import '../../components/scaffold/custom_app_bar.dart';
import '../../models/course.dart';

class CourseScreen extends StatefulWidget {

  const CourseScreen({Key? key}) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    Course course = ModalRoute.of(context)!.settings.arguments as Course;

    return Scaffold(
      appBar: CustomAppBar(
        barTitle: course.name,
      ),
      bottomNavigationBar: BottomMenu(
        onTap: (int value) {
          BottomMenu.navigateFromOtherPage(context, value);
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: CardTemplate(
          child: Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    course.name,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                const Divider(height: 0, color: Color(0xFFEEEEEE), thickness: 2),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    course.description,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                    ),
                  )
                ),
                const Divider(height: 0, color: Color(0xFFEEEEEE), thickness: 2),

                if(course.lessons.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: course.lessons.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return LessonListViewItem(
                          parentCourse: course,
                          lesson: course.lessons[index],
                          progressInfo: course.lessonProgressInfoList!.length > index ?
                            course.lessonProgressInfoList![index] : null,
                        );
                      },
                    )
                  ),
                if(course.lessons.isEmpty)
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          children:[
                            const Icon(
                              Icons.data_array,
                              color: Colors.grey,
                            ),
                            Text(
                              "No lessons attached".tr,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                      )
                  ),

              ],
            ),
          ),
        ),
      )
    );
  }
}
