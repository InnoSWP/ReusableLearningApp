import 'package:flutter/material.dart';
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
    bool authorized = false;
    manager.isAuthorized().then((value) => authorized = value);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: authorized ? "/" : "/authorize",
      routes: {
        "/": (context) => Home(),
        "/authorize": (context) => AuthorizationScreen(),
        "/create": (context) => AuthorizationScreen(),
      },
    );
  }
}
