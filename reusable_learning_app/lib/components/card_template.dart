import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTemplate extends StatefulWidget {
  Widget child;

  CardTemplate({Key? key, required this.child}) : super(key: key);

  @override
  _CardTemplateState createState() => _CardTemplateState();
}

class _CardTemplateState extends State<CardTemplate> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      elevation: 4,
      child: widget.child
    );
  }
}
