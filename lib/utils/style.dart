import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin Widgets {
  SizedBox get kWidth60 => const SizedBox(width: 60);
  SizedBox get kHeight30 => const SizedBox(height: 30);
  SizedBox get kWidth30 => const SizedBox(width: 30);
  SizedBox get kHeight15 => const SizedBox(height: 15);
  SizedBox get kWidth15 => const SizedBox(width: 15);
  SizedBox get kCoinsGap => const SizedBox(width: 25);

  double get kLetterSpacing => 0.2;

  EdgeInsets get kAll8 => const EdgeInsets.all(8);
  EdgeInsets get kHorizontal8 => const EdgeInsets.symmetric(horizontal: 8.0);
  EdgeInsets get kertical8 => const EdgeInsets.symmetric(vertical: 8.0);

  BorderRadius getBorderRadius(double size) =>
      BorderRadius.all(Radius.circular(size));
}

mixin StyleSeed {
  final _kHeadline1 =
      GoogleFonts.josefinSans(fontSize: 24, fontWeight: FontWeight.bold);
  final _kHeadline2 = GoogleFonts.orbitron(
    fontSize: 24,
  );
  final _kBodyText1 = GoogleFonts.lato(
    fontSize: 18,
  );
  final _kBodyText2 = GoogleFonts.lato(
    fontSize: 16,
  );
  TextStyle get kHeadline1 => _kHeadline1;
  TextStyle get kHeadline2 => _kHeadline2;
  TextStyle get kBodyText1 => _kBodyText1;
  TextStyle get kBodyText2 => _kBodyText2;
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

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  if (states.any(interactiveStates.contains)) {
    return Colors.amber;
  }
  return Colors.white;
}
