import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';

import '../../models/lesson.dart';

class LessonListViewItem extends StatelessWidget {
  final Lesson lesson;

  const LessonListViewItem({Key? key, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          "/lesson",
          arguments: lesson
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 200,
            child: Text(
              lesson.name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: CustomColors.purple
              ),
            )
          ),
          const Icon(
            Icons.arrow_forward_ios, size: 21,
            color: CustomColors.purple,
          )
        ],
      )
    );
  }
}
