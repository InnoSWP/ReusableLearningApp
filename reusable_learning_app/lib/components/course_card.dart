
import 'package:flutter/material.dart';
import 'package:reusable_app/authorization/authorization_manager.dart';
import 'package:reusable_app/authorization/server_api.dart';
import 'package:reusable_app/components/card_template.dart';
import 'package:reusable_app/models/token_secure_storage.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';
import 'package:reusable_app/screens/lessons/course_screen.dart';

import '../models/course.dart';
import 'package:get/get.dart';


class CourseCard extends StatefulWidget {
  final Course course;
  late bool isFav;

  CourseCard({Key? key, required this.course, required bool isFav}) : super(key: key) {
    this.isFav = isFav;
  }

  @override
  State<StatefulWidget> createState() => CourseCardState();

}


class CourseCardState extends State<CourseCard> {

  ServerApi api = ServerApi(storage: TokenSecureStorage());

  void goToCourse(BuildContext context) {
    Navigator.of(context).pushNamed(
      "/course",
      arguments: widget.course
    );
  }
  Future changeFavoriteCourseState(int id) async {
    await api.changeFavoriteCourseState(id);
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
                      widget.course.name,
                      style: Theme.of(context).textTheme.titleMedium
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      widget.course.description,
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
                    icon: widget.isFav ?
                      const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
                    onPressed: () async {
                      await changeFavoriteCourseState(widget.course.id);
                      setState(() {
                        widget.isFav = !widget.isFav;
                      });
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
