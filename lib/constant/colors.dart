import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF101116);
  static const Color secondary = Color(0xFF246BFD);
  static const Color onPrimaryText = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF2F3540);
  static const Color onSurFace = Color(0xFFD6D7F0);
  static const Color green = Color(0xFF90D177);
  static const Color danger = Color.fromARGB(255, 255, 76, 44);
  // screen color
  static const LinearGradient backgroundColorScreen = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(
      0,
      60,
    ),
    colors: [
      primaryColor,
      secondary,
      primaryColor,
      secondary,
    ],
  );
  static const LinearGradient bgCarde = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(0, 16, 17, 22),
        Color.fromARGB(255, 16, 17, 22),
      ],
      stops: [
        0.4,
        20
      ]);
}
