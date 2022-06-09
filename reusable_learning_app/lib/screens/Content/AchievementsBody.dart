import 'package:flutter/material.dart';

class AchievementsBody extends StatefulWidget {
  const AchievementsBody({Key? key}) : super(key: key);

  @override
  AchievementsBodyState createState() => AchievementsBodyState();
}

class AchievementsBodyState extends State<AchievementsBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              title: Text("Achievements", textAlign: TextAlign.center),
          ),
          body: const Center(
              child: Text("Achievements page")),
        ));
  }
}
