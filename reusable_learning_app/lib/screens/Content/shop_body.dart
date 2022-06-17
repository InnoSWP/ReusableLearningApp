import 'package:flutter/material.dart';

import '../../models/interfaces/nav_item.dart';

class ShopBody extends StatefulWidget implements NavItem {
  ShopBody({Key? key}) : super(key: key);

  @override
  ShopBodyState createState() => ShopBodyState();

  @override
  String title = "Shop";
}

class ShopBodyState extends State<ShopBody>   {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text("Shop page"),
    );
  }

}
