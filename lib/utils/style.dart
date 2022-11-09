import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin Widgets {
  SizedBox get kWidth60 => const SizedBox(width: 60);
  SizedBox get kHeight30 => const SizedBox(height: 30);
  SizedBox get kWidth30 => const SizedBox(width: 30);
  SizedBox get kHeight15 => const SizedBox(height: 15);
  SizedBox get kWidth15 => const SizedBox(width: 15);
  SizedBox get kCoinsGap => const SizedBox(width: 40);

  double get kLs => 0.2;
  Color get kBgColor => const Color(0xFFEDEDED);
  Color get kBoxColor => Colors.white70;
  Color? get kGrey => Colors.grey[500];
  Color? get kShadow => Colors.grey.shade300;

  EdgeInsets get kAll8 => const EdgeInsets.all(8);
  EdgeInsets get kAll4 => const EdgeInsets.all(4);
  EdgeInsets get kHorizontal8 => const EdgeInsets.symmetric(horizontal: 8.0);
  EdgeInsets get kVertical8 => const EdgeInsets.symmetric(vertical: 8.0);

  BorderRadius getBorderRadius(double size) =>
      BorderRadius.all(Radius.circular(size));
}

mixin StyleSeed {
  TextStyle get kHeadline1 =>
      GoogleFonts.josefinSans(fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle get kHeadline2 => GoogleFonts.orbitron(fontSize: 24);
  TextStyle get kBodyText1 => GoogleFonts.lato(fontSize: 18);
  TextStyle get kBodyText2 => GoogleFonts.lato(fontSize: 16);
}

class Styles with StyleSeed {
  Styles._internal(this.darkMode);
  factory Styles.getInstance(bool darkMode) => Styles._internal(darkMode);
  final bool darkMode;

  TextTheme get _textTheme => TextTheme(
        headline1: darkMode == true
            ? kHeadline1
            : kHeadline1.copyWith(color: Colors.black),
        headline2: darkMode == true
            ? kHeadline2
            : kHeadline2.copyWith(color: Colors.black),
        bodyText1: darkMode == true
            ? kBodyText1
            : kBodyText1.copyWith(color: Colors.black),
        bodyText2: darkMode == true
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

Color? getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  if (states.any(interactiveStates.contains)) {
    return Colors.white;
  }
  return Colors.white10;
}
