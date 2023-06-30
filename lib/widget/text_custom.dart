import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSise;
  final FontWeight fontWeight;
  final double marginleft;
  final double marginright;
  final double marginTop;
  final double marginBottom;
  final TextAlign textAlign;

  const TextCustom({
    super.key,
    required this.text,
    this.color = Colors.white,
    this.fontSise = 15,
    this.fontWeight = FontWeight.normal,
    this.marginleft = 0,
    this.marginright = 0,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            top: marginTop,
            bottom: marginBottom,
            left: marginleft,
            right: marginright),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: fontSise,
            fontWeight: fontWeight,
          ),
          textAlign: textAlign,
        ));
  }
}
