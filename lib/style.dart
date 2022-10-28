import 'package:flutter/material.dart';

mixin Widgets {
  SizedBox get kWidth60 => const SizedBox(width: 60);
  SizedBox get kHeight30 => const SizedBox(height: 30);
  SizedBox get kWidth30 => const SizedBox(width: 30);
  SizedBox get kHeight15 => const SizedBox(height: 15);
  SizedBox get kWidth15 => const SizedBox(width: 15);
  SizedBox get kCoinsGap => const SizedBox(width: 25);

  EdgeInsets get kAll8 => const EdgeInsets.all(8.0);
  EdgeInsets get kHorizontal8 => const EdgeInsets.symmetric(horizontal: 8.0);
  EdgeInsets get kVertical8 => const EdgeInsets.symmetric(vertical: 8.0);

  BorderRadius getBorderRadius(double size) =>
      BorderRadius.all(Radius.circular(size));
}

mixin StyleSeed {
  TextStyle get kHeadline1 =>
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle get kHeadline2 =>
      const TextStyle(fontSize: 20, fontWeight: FontWeight.normal);
  TextStyle get kBodyText1 =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.normal);
  TextStyle get kBodyText2 =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.normal);
}

class Styles with StyleSeed {
  Styles._internal(this.darkmode);
  factory Styles.getInstance(bool darkmode) => Styles._internal(darkmode);
  final bool darkmode;

  TextTheme get _textTheme => TextTheme(
        headline1: darkmode == true
            ? kHeadline1
            : kHeadline1.copyWith(color: Colors.black),
        headline2: darkmode == true
            ? kHeadline2
            : kHeadline2.copyWith(color: Colors.black),
        bodyText1: darkmode == true
            ? kBodyText1
            : kBodyText1.copyWith(color: Colors.black),
        bodyText2: darkmode == true
            ? kBodyText2
            : kBodyText2.copyWith(color: Colors.black),
      );

  ThemeData get themeLight =>
      ThemeData(useMaterial3: true, textTheme: _textTheme);

  ThemeData get themeDark => ThemeData.dark().copyWith(
        useMaterial3: true,
        textTheme: _textTheme,
      );
}
