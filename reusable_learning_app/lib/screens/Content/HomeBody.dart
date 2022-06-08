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
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Course name", textAlign: TextAlign.center),
            leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            actions: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: IconButton(onPressed: () {}, icon: const Icon(Icons.search))),
            ],
          ),
          body: const Center(child: Text("Main page")),
        ));
  }
}
