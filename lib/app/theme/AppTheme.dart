import 'package:flutter/material.dart';
import 'package:groupware/app/color/AppColor.dart';
import 'package:groupware/app/font/AppFont.dart';

class AppTheme {
  static final defaultTheme = ThemeData(
    backgroundColor: AppColor.defaultBgColor,
    scaffoldBackgroundColor: AppColor.defaultScaffoldBgColor,
    textTheme:
        TextTheme(headline1: AppFont.headLine1, headline4: AppFont.headLine4),
  );
}
