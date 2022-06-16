import 'package:flutter/material.dart';
import 'package:reusable_app/models/utilities/token_api.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';
import 'package:reusable_app/screens/home.dart';
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
      theme: ThemeData(
          primaryColor: CustomColors.purple
      ),
      routes: {
        "/home": (context) => Home(),
        "/authorize": (context) => AuthorizationScreen(),
        "/create": (context) => AuthorizationScreen(),
        // TODO new routes: /favCourses, /favLessons, /devChat, /edit
      },
      home: FutureBuilder<bool>(
        future: manager.isAuthorized(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if(snapshot.hasData) {
            // if(snapshot.data!) {
            //   return Home();
            // }
            // else {
            //   return AuthorizationScreen();
            // }
            return Home();
          }
          else {
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

