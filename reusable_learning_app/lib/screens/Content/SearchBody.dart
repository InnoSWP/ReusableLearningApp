import 'package:flutter/material.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  SearchBodyState createState() => SearchBodyState();
}

class SearchBodyState extends State<SearchBody> {
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
              child: Text("Search page")),
        ));
  }
}
