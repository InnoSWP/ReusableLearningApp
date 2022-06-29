import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reusable_app/authorization/server_api.dart';
import 'package:reusable_app/models/progress/lesson_progress_info.dart';
import 'package:reusable_app/models/token_secure_storage.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';

import '../../models/course.dart';
import '../../models/lesson.dart';

class LessonListViewItem extends StatelessWidget {
  final Lesson lesson;
  final Course parentCourse;
  final LessonProgressInfo? progressInfo;
  final ServerApi serverApi = ServerApi(storage: TokenSecureStorage());

  LessonListViewItem({Key? key, required this.lesson,
    required this.progressInfo, required this.parentCourse}) : super(key: key);

  String getProgressString() {
    if (progressInfo == null) {
      return "Not Started";
    }
    if (progressInfo!.status == "CM") {
      return "Completed";
    } else if (progressInfo!.status == "PR") {
      return "In Progress";
    }
    return "Not Started";
  }
  Color getProgressTextColor() {
    if (progressInfo == null) {
      return Colors.grey[600]!;
    }
    if (progressInfo!.status == "CM") {
      return Colors.green;
    } else if (progressInfo!.status == "PR") {
      return Colors.orange;
    }
    return Colors.grey[600]!;
  }


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (progressInfo == null) {
          //todo: lesson level to id
          serverApi.setLessonInProgress(parentCourse.id, lesson.level + 1);
        }
        Navigator.of(context).pushNamed(
          "/lesson",
          arguments: [lesson, parentCourse, progressInfo]
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.name,
                  style: Theme.of(context).textTheme.titleSmall
                ),
                SizedBox(height: 5),
                Text(
                  getProgressString(),
                  style: TextStyle(
                    color: getProgressTextColor()
                  )
                ),
              ],
            )
          ),
          Icon(
            Icons.arrow_forward_ios, size: 21,
            color: Theme.of(context).iconTheme.color,
          )
        ],
      )
    );
  }
}
