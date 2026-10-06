import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Style — editorial spec sheet: paper, ink, one signal colour, no rounding.
// ---------------------------------------------------------------------------

class AppColors {
  static const paper = Color(0xFFEDEAE3);
  static const black = Color(0xFF111111);
  static const grey = Color(0xFF77736B);
  static const signal = Color(0xFFFF4A1C);
}

const monoFont = 'Menlo';
const displayFont = 'Helvetica Neue';

const rule = BorderSide(color: AppColors.black, width: 2);
const hairline = BorderSide(color: AppColors.black, width: 1);

TextStyle mono(
  double size, {
  Color color = AppColors.black,
  FontWeight? weight,
}) => TextStyle(
  fontFamily: monoFont,
  fontSize: size,
  color: color,
  fontWeight: weight,
  letterSpacing: 0.5,
);
