
import 'package:flutter/material.dart';
import 'package:reusable_app/components/card_template.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';
import 'package:reusable_app/screens/lessons/course_screen.dart';

import '../models/course.dart';
import 'package:get/get.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final bool isFav;

  const CourseCard({Key? key, required this.course, required this.isFav}) : super(key: key);

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
                      style: Theme.of(context).textTheme.titleMedium
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      course.description,
                      style: Theme.of(context).textTheme.bodySmall,
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
                  style: Theme.of(context).textButtonTheme.style,
                  onPressed: () {
                    goToCourse(context);
                  },
                  child: Text(
                    'LEARN'.tr,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                InkWell(
                  child: IconButton(
                    icon: isFav ?
                      const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
                    onPressed: () {
                      print("dw");
                    },
                  ),
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}
