import 'package:flutter/material.dart';

class ProjectColors {
  static const Color projectBackgroundColor =
      Color.fromARGB(255, 237, 236, 236);
  static const Color projectPrimaryWidgetColor =
      Color.fromARGB(255, 61, 217, 136);
  static const Color projectSecondaryWidgetColor =
      Color.fromARGB(255, 113, 113, 113);
  static const Color defaultTextColor = Colors.black;
  static const Color optionalTextColor1 = Color.fromARGB(255, 205, 205, 205);
  static const Color optionalTextColor2 = Color.fromARGB(255, 49, 166, 100);
  static const Color projectDefaultColor = Colors.white;
  static const Color projectTransparentColor = Colors.transparent;
  static const Color imageBorderColor = Color.fromARGB(255, 184, 184, 184);
}

class ProjectTextStyles {
  static const TextStyle styleDrawerTitle = TextStyle(
      color: ProjectColors.projectDefaultColor,
      fontSize: 30,
      fontWeight: FontWeight.w400);

  static const TextStyle styleTopSectionRegionButtonText =
      TextStyle(color: ProjectColors.optionalTextColor1);

  static const TextStyle styleDrawerTextLine = TextStyle(
      color: ProjectColors.defaultTextColor, fontWeight: FontWeight.w500);

  static const TextStyle styleListViewGeneral = TextStyle(
      color: ProjectColors.optionalTextColor2,
      fontSize: 15,
      fontWeight: FontWeight.w700);
}
