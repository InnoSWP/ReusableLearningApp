import 'package:flutter/material.dart';

import '../../models/interfaces/NavBarItem.dart';

class Search extends StatefulWidget implements NavBarItem{
  Search({Key? key}) : super(key: key);
  @override
  String? title = "Search";
  @override
  State<StatefulWidget> createState() => _SearchState();
}
class _SearchState extends State {
  @override
  Widget build(BuildContext context ) {
    return Center(child: Text("Search"));
  }
}