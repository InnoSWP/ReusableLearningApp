import 'package:flutter/material.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';
import 'package:reusable_app/screens/home.dart';
import 'package:reusable_app/screens/lessons/course_screen.dart';
import 'package:reusable_app/screens/lessons/lesson_screen.dart';
import 'authorization/authorization_manager.dart';
import 'screens/authorization/authorization_screen.dart';

void main() {
  runApp(const LearningApp());
}

class LearningApp extends StatefulWidget {
  const LearningApp({Key? key}) : super(key: key);

  @override
  State createState() => _LearningAppState();
}

class _LearningAppState extends State {
  var manager = AuthorizationManager();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: CustomColors.purple),
      routes: {
        "/home": (context) => Home(),
        "/authorize": (context) => const AuthorizationScreen(),
        "/create": (context) => const AuthorizationScreen(),
        "/course": (context) => const CourseScreen(),
        "/lesson": (context) => const LessonScreen(),
        // TODO new routes: /favCourses, /favLessons, /devChat, /edit
      },
      home: FutureBuilder<bool>(
        future: manager.isAuthorized(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return Home();
            } else {
              return const AuthorizationScreen();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
