import 'package:flutter/material.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  SettingsBodyState createState() => SettingsBodyState();
}

class SettingsBodyState extends State<SettingsBody> {
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
              child: Text("Settings page")),
        ));
  }
}
