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
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Search", textAlign: TextAlign.center),
          ),
          body: const Center(
              child: Text("Search page")),
        ));
  }
}
