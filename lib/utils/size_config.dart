import 'package:flutter/material.dart';

class SizeConfig {
  //initOnStartUp
  static MediaQueryData mediaQuery = const MediaQueryData();
  static double width = 0;
  static double height = 0;

  static void initOnStartUp(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    width = mediaQuery.size.width;
    height = mediaQuery.size.height;
  }
}
