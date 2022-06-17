import 'package:flutter/material.dart';

import '../models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({Key? key, required this.course}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {

      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 4),
            )
          ]
        ),

        child: Padding(
          padding: const EdgeInsets.all(20),
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
              Row(
                children: [
                  TextButton(
                    onPressed: () {  },
                    child: Text("LEARN"),
                  ),
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
