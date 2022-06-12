import 'package:flutter/material.dart';

import '../../models/interfaces/nav_item.dart';

class SearchBody extends StatefulWidget implements NavItem {
  SearchBody({Key? key}) : super(key: key);

  @override
  SearchBodyState createState() => SearchBodyState();

  @override
  String title = "Search";
}

class SearchBodyState extends State<SearchBody>   {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text("Search page"),
    );
  }

}
