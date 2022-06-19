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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 4),
            )
          ]
      ),

      child: widget.child
    );
  }
}
