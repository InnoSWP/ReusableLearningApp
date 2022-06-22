import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/interfaces/nav_item.dart';

class ShopBody extends StatefulWidget implements NavItem {
  ShopBody({Key? key}) : super(key: key);

  @override
  ShopBodyState createState() => ShopBodyState();

  @override
  String title = ("Shop".tr);
}

class ShopBodyState extends State<ShopBody>   {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("Shop page".tr),
    );
  }

}
