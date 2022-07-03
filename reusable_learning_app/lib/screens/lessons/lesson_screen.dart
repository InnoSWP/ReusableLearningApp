import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reusable_app/authorization/server_api.dart';
import 'package:reusable_app/components/card_template.dart';
import 'package:reusable_app/components/scaffold/bottom_menu.dart';
import 'package:reusable_app/components/scaffold/custom_app_bar.dart';
import 'package:reusable_app/models/progress/lesson_progress_info.dart';
import 'package:reusable_app/models/token_secure_storage.dart';
import '../../models/course.dart';
import '../../models/lesson.dart';
import '../../models/utilities/custom_colors.dart';
import 'package:get/get.dart';


class LessonScreen extends StatefulWidget {
  const LessonScreen({Key? key}) : super(key: key);

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {

  ServerApi serverApi = ServerApi(storage: TokenSecureStorage());

  void _snackBarLessonCompleted(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Lesson has been completed!',
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    Lesson lesson = args[0] as Lesson;
    Course parentCourse = args[1] as Course;
    LessonProgressInfo? progressInfo = args[2] as LessonProgressInfo?;

    return Scaffold(
      appBar: CustomAppBar(
        barTitle: "${'Lesson'.tr}: ${lesson.name}",
      ),
      bottomNavigationBar: BottomMenu(
        onTap: (value) => BottomMenu.navigateFromOtherPage(context, value),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CardTemplate(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      lesson.name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  const Divider(color: Color(0xFFEEEEEE), thickness: 2, height: 0,),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      lesson.content,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400
                      ),
                    )
                  ),
                  const Divider(color: Color(0xFFEEEEEE), thickness: 2, height: 0,),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: TextButton(
                        onPressed: () {
                          if (progressInfo == null || progressInfo.status == 'PR') {
                            serverApi.setLessonCompleted(parentCourse.id, lesson.id);
                            _snackBarLessonCompleted(context);
                          }
                          Navigator.pop(context, true);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.transparent
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              side: BorderSide(
                               width: 1,
                               color: Theme.of(context).iconTheme.color!
                              ),
                              borderRadius: BorderRadius.circular(10)
                            )
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            "Complete lesson".tr,
                            style: TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    )
                  ),

                ],
              ),
            ),
            // Center(
            //   child: Text("Forum here"),
            // )
          ],
        )
      ),
    );
  }

}
