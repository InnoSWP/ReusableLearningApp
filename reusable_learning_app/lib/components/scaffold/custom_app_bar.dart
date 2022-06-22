import 'package:flutter/material.dart';
import '../../models/utilities/custom_colors.dart';
import '../../screens/Content/notifications_screen.dart';
import 'package:get/get.dart';


class CustomAppBar extends AppBar {
  final String barTitle;

  CustomAppBar({Key? key, required this.barTitle}) : super(key: key);@override

  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.purple,
      title: Text(widget.barTitle.tr, textAlign: TextAlign.center),
      actions: [
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsBody()));}, icon: const Icon(Icons.notifications))),
      ],
    );
  }
}
