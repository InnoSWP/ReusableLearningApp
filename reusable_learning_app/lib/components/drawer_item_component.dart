import 'package:flutter/material.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';

class DrawerItemComponent extends StatefulWidget {
  IconData icon_data;
  String itemName;
  bool selected;
  String route;

  DrawerItemComponent(this.icon_data, this.itemName,
      {Key? key, this.selected = false, this.route = "/"}) : super(key: key);

  @override
  _DrawerItemComponentState createState() => _DrawerItemComponentState();

}

class _DrawerItemComponentState extends State<DrawerItemComponent> {


  @override
  Widget build(BuildContext context) {
    late TextStyle style;
    late Icon icon;
    if(ModalRoute.of(context)!.settings.name == widget.route) {
      widget.selected = true;
      style = const TextStyle(
          fontSize: 17,
          color: CustomColors.purple
      );
      icon = Icon(widget.icon_data, color: CustomColors.purple);

    }
    else {
      style = const TextStyle(
          fontSize: 17,
          color: CustomColors.grey
      );
      icon = Icon(widget.icon_data, color: CustomColors.grey);
    }
    return TextButton(
      onPressed: () {  },
      style: ButtonStyle(
        overlayColor: widget.selected ? MaterialStateProperty.all(Colors.transparent) : null,
        backgroundColor: widget.selected ? MaterialStateProperty.all(Color(0xFFf7f0ff)) : null
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
        child: Row(
          children: [
            icon,
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(
                widget.itemName,
                style: style
              ),
            )
          ],
        ),
      ),
    );
  }
}