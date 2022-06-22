import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reusable_app/components/card_template.dart';
import 'package:reusable_app/components/scaffold/bottom_menu.dart';
import 'package:reusable_app/components/scaffold/custom_app_bar.dart';
import '../../models/lesson.dart';
import '../../models/utilities/custom_colors.dart';
import 'package:get/get.dart';


class LessonScreen extends StatefulWidget {
  const LessonScreen({Key? key}) : super(key: key);

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    Lesson lesson = ModalRoute.of(context)!.settings.arguments as Lesson;

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
              child: Container(
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
                    const Divider(color: const Color(0xFFEEEEEE), thickness: 2, height: 0,),
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
                    const Divider(color: const Color(0xFFEEEEEE), thickness: 2, height: 0,),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(CustomColors.purple)
                          ),
                          child: Text("Complete lesson".tr),
                        ),
                      )
                    ),

                  ],
                ),
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
