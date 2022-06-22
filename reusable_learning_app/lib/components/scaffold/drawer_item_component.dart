import 'package:flutter/material.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';

class DrawerItemComponent extends StatefulWidget {
  IconData iconData;
  String itemName;
  bool selected;
  String route;

  DrawerItemComponent(this.iconData, this.itemName,
      {Key? key, this.selected = false, this.route = "/"}) : super(key: key);

  @override
  _DrawerItemComponentState createState() => _DrawerItemComponentState();

}

class _DrawerItemComponentState extends State<DrawerItemComponent> {


  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme.labelSmall;
    var icon = Icon(widget.iconData, color: style?.color);

    return TextButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, widget.route);
      },
      style: ButtonStyle(
        overlayColor: widget.selected ? MaterialStateProperty.all(Colors.transparent) : null,
        backgroundColor: widget.selected ? MaterialStateProperty.all(const Color(0xFFf7f0ff)) : null
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
        child: Row(
          children: [
            icon,
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: SizedBox(
                width: 200,
                child: Text(
                  widget.itemName,
                  style: style
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}