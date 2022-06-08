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
        theme: ThemeData.dark(),
        home: const Scaffold(
          body: Padding(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Text("Achievements page")),
        ));
  }
}
