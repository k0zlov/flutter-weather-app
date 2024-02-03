import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ApplicationTheme {
  static ThemeData lightThemeData = themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      scaffoldBackgroundColor: colorScheme.background,
      focusColor: focusColor,
    );
  }

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(147, 238, 241, 1.0),
    onPrimary: Color.fromRGBO(40, 42, 58, 1.0),
    secondary: Color.fromRGBO(179, 181, 189, 1.0),
    onSecondary: Color.fromRGBO(64, 66, 82, 1.0),
    error: Colors.redAccent,
    onError: Colors.white70,
    background: Color.fromRGBO(243, 244, 248, 1.0),
    onBackground: Color.fromRGBO(210, 212, 218, 1.0),
    surface: Color.fromRGBO(243, 244, 248, 1.0),
    onSurface: Color.fromRGBO(30, 29, 29, 1.0),
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromRGBO(200, 231, 233, 1.0),
    onPrimary: Color.fromRGBO(50, 67, 74, 1.0),
    secondary: Color.fromRGBO(30, 31, 36, 1.0),
    onSecondary: Color.fromRGBO(131, 137, 143, 1.0),
    error: Colors.redAccent,
    onError: Colors.white70,
    background: Color.fromRGBO(30, 31, 36, 1.0),
    onBackground: Color.fromRGBO(46, 46, 56, 1.0),
    surface: Color.fromRGBO(30, 31, 36, 1.0),
    onSurface: Color.fromRGBO(255, 255, 255, 1.0),
  );

  /// Text Theme
  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headlineSmall: GoogleFonts.karla(fontWeight: _medium, fontSize: 22.0),
    headlineMedium: GoogleFonts.karla(fontWeight: _bold, fontSize: 30.0),
    headlineLarge: GoogleFonts.karla(fontWeight: _bold, fontSize: 38.0),

    bodySmall: GoogleFonts.karla(fontWeight: _semiBold, fontSize: 12.0),
    bodyMedium: GoogleFonts.karla(fontWeight: _regular, fontSize: 14.0),
    bodyLarge: GoogleFonts.karla(fontWeight: _regular, fontSize: 16.0),

    titleSmall: GoogleFonts.karla(fontWeight: _medium, fontSize: 14.0),
    titleMedium: GoogleFonts.karla(fontWeight: _bold, fontSize: 18.0),
    titleLarge: GoogleFonts.karla(fontWeight: _bold, fontSize: 22.0),

    labelSmall: GoogleFonts.karla(fontWeight: _medium, fontSize: 12.0),
    labelLarge: GoogleFonts.karla(fontWeight: _semiBold, fontSize: 16.0),
  );
}
