import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const darkColor = 0xFF08080C;
const lightColor = 0xFFF5F5F7;
const colorPrimary = 0xFF12121A;
const colorSecondary = 0xFF6E4BA8;
const colorAccent1 = 0xFFEFFF42;
const colorAccent2 = 0xFFD4AF37;

/// The main theme of the app.
class MainAppTheme {
  const MainAppTheme();

  ThemeData getMainTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(colorPrimary),
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.bungee(color: Color(colorAccent1)),
        titleMedium: GoogleFonts.bungee(color: Color(colorAccent1)),
        titleSmall: GoogleFonts.bungee(color: Color(colorAccent1)),
        bodyLarge: GoogleFonts.quicksand(
          fontSize: 18,
          fontWeight: FontWeight(400),
        ),
        bodyMedium: GoogleFonts.quicksand(
          fontSize: 18,
          fontWeight: FontWeight(400),
        ),
        bodySmall: GoogleFonts.quicksand(),
        labelLarge: GoogleFonts.quicksand(
          fontSize: 24,
          fontWeight: FontWeight(400),
        ),
        labelMedium: GoogleFonts.quicksand(
          fontSize: 18,
          fontWeight: FontWeight(400),
        ),
        labelSmall: GoogleFonts.quicksand(
          fontSize: 12,
          fontWeight: FontWeight(400),
          color: Colors.grey,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Color(colorSecondary)),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          hoverColor: Color(colorSecondary),
          foregroundColor: Color(lightColor),
        ),
      ),
      iconTheme: IconThemeData(),
    );
  }
}
