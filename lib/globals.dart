import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Color NAV_COLOR = const Color(0xFF2E2739);
Color LIGHT_COLOR = const Color(0xFFF6F6FA);
Color BUTTON_COLOR = const Color(0xFF61C3F2);
Color GREY_COlOR = const Color(0xFFDBDBDF);
Color TEXT_COLOR = const Color(0xFF827D88);

String API_KEY = "41a9e7acecdf084966a5a328bbb28470";

List<Color> GENERS_COLORS = [
  const Color(0xFF15D2BC),
  const Color(0xFFE26CA5),
  const Color(0xFF564CA3),
  const Color(0xFFCD9D0F),
];

getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

TextStyle normalTextStyle([Color? color, TextDecoration? decoration]) {
  color ??= const Color(0xFF202C43);
  return GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
      decoration: decoration);
}

TextStyle headingTextStyle([Color? color, TextDecoration? decoration]) {
  color ??= const Color(0xFFFFFFFF);
  return GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: color,
      decoration: decoration);
}

TextStyle smallTextStyle([Color? color, TextDecoration? decoration]) {
  color ??= const Color(0xFFFFFFFF);
  return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color,
      decoration: decoration);
}

TextStyle extraSmallTextStyle([Color? color, TextDecoration? decoration]) {
  color ??= const Color(0xFFFFFFFF);
  return GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: color,
      decoration: decoration);
}
