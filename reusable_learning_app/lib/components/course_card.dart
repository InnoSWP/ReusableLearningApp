
import 'package:flutter/material.dart';
import 'package:reusable_app/components/card_template.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';
import 'package:reusable_app/screens/lessons/course_screen.dart';

import '../models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({Key? key, required this.course}) : super(key: key);

  void goToCourse(BuildContext context) {
    Navigator.of(context).pushNamed(
      "/course",
      arguments: course
    );
  }

  @override
  Widget build(BuildContext context) {
    return CardTemplate(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                goToCourse(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      course.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      course.description,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                        height: 1.3
                      ),
                      maxLines: 6,

                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    goToCourse(context);
                  },
                  child: const Text(
                    "LEARN",
                    style: TextStyle(
                      fontSize: 15,
                      color: CustomColors.purple
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_outline),
                  onPressed: () => {  },
                )
              ]
            )
          ],
        ),
      ),
    );
  }
}
