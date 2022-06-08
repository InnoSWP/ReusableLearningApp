import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  HomeBodyState createState() => HomeBodyState();
}

class HomeBodyState extends State<HomeBody> {
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
              child: Text("Main page")),
        ));
  }
}