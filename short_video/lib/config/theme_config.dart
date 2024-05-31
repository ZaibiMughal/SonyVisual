import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_config.dart';

class ThemeConfig{
  ThemeConfig._();

  static const int lightTheme = 0;
  static const int darkTheme = 1;

  static ThemeData lightThemeData = ThemeData.light().copyWith(
    primaryColor: ColorsConfig.p_l_color,
    primaryColorDark: ColorsConfig.s_l_color,
    primaryColorLight: ColorsConfig.p_l_color,
    // scaffoldBackgroundColor: ColorsConfig.backgroundColor,
    scaffoldBackgroundColor: ColorsConfig.backgroundColor,
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: ColorsConfig.l_u_s_iconColor),
    appBarTheme: const AppBarTheme(color: ColorsConfig.p_l_color),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsConfig.l_boxBackgroundColor,
        foregroundColor: ColorsConfig.l_boxTextColor,
        side: const BorderSide(color: ColorsConfig.p_l_borderColor)
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsConfig.l_boxBackgroundColor,
        foregroundColor: ColorsConfig.l_boxTextColor,
        side: const BorderSide(color: ColorsConfig.p_l_borderColor)
      ),
    ),
    textTheme: TextTheme(
        headlineLarge: GoogleFonts.poppins().copyWith(
          color: ColorsConfig.l_headingColor,
          fontWeight: FontWeight.bold
        ),
        headlineMedium: GoogleFonts.poppins().copyWith(
            color: ColorsConfig.l_headingColor,
            fontWeight: FontWeight.bold
        ),
        headlineSmall: GoogleFonts.poppins().copyWith(
            color: ColorsConfig.l_headingColor
        ),
        titleLarge: GoogleFonts.poppins().copyWith(
            color: ColorsConfig.l_headingColor,
            fontWeight: FontWeight.bold
        ),
        titleMedium: GoogleFonts.poppins().copyWith(
            color: ColorsConfig.l_headingColor,
            fontWeight: FontWeight.bold
        ),
        titleSmall: GoogleFonts.poppins().copyWith(
            color: ColorsConfig.l_headingColor,
            fontWeight: FontWeight.bold
        ),
        bodyLarge: GoogleFonts.poppins().copyWith(
            color: ColorsConfig.p_l_textColor
        ),
        bodyMedium: GoogleFonts.poppins().copyWith(
            color: ColorsConfig.p_l_textColor
        ),
        bodySmall: GoogleFonts.poppins().copyWith( // Caption
            color: ColorsConfig.p_l_textColor
        ),
        labelLarge: GoogleFonts.poppins().copyWith(
            color: ColorsConfig.s_l_textColor
        ),
        labelMedium: GoogleFonts.poppins().copyWith(
            color: ColorsConfig.s_l_textColor
        ),
        labelSmall: GoogleFonts.poppins().copyWith(
            color: ColorsConfig.captionColor
        ),
      ),
  );

  static ThemeData darkThemeData = ThemeData.dark().copyWith(
    primaryColor: ColorsConfig.p_d_color,
    primaryColorDark: ColorsConfig.p_d_color,
    primaryColorLight: ColorsConfig.s_d_color,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorsConfig.backgroundColor,
    // scaffoldBackgroundColor: ColorsConfig.backgroundColor,

    iconTheme: const IconThemeData(color: ColorsConfig.d_u_s_iconColor),
    appBarTheme: const AppBarTheme(color: ColorsConfig.p_d_color),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: ColorsConfig.d_boxBackgroundColor,
        foregroundColor: ColorsConfig.d_boxTextColor,
        side: const BorderSide(color: ColorsConfig.p_d_borderColor)
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsConfig.d_boxBackgroundColor, // background (button) color
        foregroundColor: ColorsConfig.d_boxTextColor, // foreground (text) color
        side: const BorderSide(color: ColorsConfig.p_d_borderColor)
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.poppins().copyWith(
          color: ColorsConfig.p_d_textColor,
          fontWeight: FontWeight.bold
      ),
      headlineMedium: GoogleFonts.poppins().copyWith(
          color: ColorsConfig.p_d_textColor,
          fontWeight: FontWeight.bold
      ),
      headlineSmall: GoogleFonts.poppins().copyWith(
          color: ColorsConfig.p_d_textColor
      ),
      titleLarge: GoogleFonts.poppins().copyWith(
          color: ColorsConfig.p_d_textColor,
          fontWeight: FontWeight.bold
      ),
      titleMedium: GoogleFonts.poppins().copyWith(
          color: ColorsConfig.p_d_textColor,
          fontWeight: FontWeight.bold
      ),
      titleSmall: GoogleFonts.poppins().copyWith(
          color: ColorsConfig.p_d_textColor,
          fontWeight: FontWeight.bold
      ),
      bodyLarge: GoogleFonts.poppins().copyWith(
          color: ColorsConfig.p_d_textColor
      ),
      bodyMedium: GoogleFonts.poppins().copyWith(
          color: ColorsConfig.p_d_textColor
      ),
      bodySmall: GoogleFonts.poppins().copyWith( // Caption
          color: ColorsConfig.captionColor
      ),
      labelLarge: GoogleFonts.poppins().copyWith(
          color: ColorsConfig.p_d_textColor
      ),
      labelMedium: GoogleFonts.poppins().copyWith(
          color: ColorsConfig.p_d_textColor
      ),
      labelSmall: GoogleFonts.poppins().copyWith(
          color: ColorsConfig.captionColor
      ),
    ),
  );

}