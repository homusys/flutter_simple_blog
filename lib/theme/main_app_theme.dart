import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';

/// The main theme of the app.
class MainAppTheme {
  const MainAppTheme();

  ThemeData getMainTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(colorPrimary),
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.bungee(),
        titleMedium: GoogleFonts.bungee(),
        titleSmall: GoogleFonts.bungee(),
        bodyLarge: GoogleFonts.quicksand(),
        bodyMedium: GoogleFonts.quicksand(),
        bodySmall: GoogleFonts.quicksand(),
        labelLarge: GoogleFonts.quicksand(fontWeight: FontWeight(700)),
        labelMedium: GoogleFonts.quicksand(fontWeight: FontWeight(700)),
        labelSmall: GoogleFonts.quicksand(),
      ),
    );
  }
}
