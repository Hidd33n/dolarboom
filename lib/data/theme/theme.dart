import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colores para el tema claro
static const Color lightBackgroundColor = Color(0xFFE0E0E0); // Fondo gris claro para que los elementos destaquen
static const Color lightCardColor = Color(0xFFFFFFFF); // Fondo blanco para las tarjetas
static const Color lightPrimaryTextColor = Color(0xFF212121); // Texto primario gris oscuro
static const Color lightSecondaryTextColor = Color(0xFF616161); // Texto secundario gris medio
static const Color lightIconColor = Color(0xFF424242); // Íconos gris oscuro
static Color lightButtonColor = Color(0xFF009688); // Verde esmeralda para botones (color de acento)


  // Colores para el tema oscuro
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkCardColor = Color(0xFF1E1E1E);
  static const Color darkPrimaryTextColor = Colors.white;
  static const Color darkSecondaryTextColor = Colors.white70;
  static const Color darkIconColor = Colors.white;
  static  Color darkButtonColor = Colors.grey[700]!; // Gris medio para botones

  // Tema Claro
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: lightBackgroundColor,
    scaffoldBackgroundColor: lightBackgroundColor,
    cardColor: lightCardColor,
    appBarTheme: AppBarTheme(
      color: lightBackgroundColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: lightIconColor),
      titleTextStyle: GoogleFonts.bebasNeue(
        fontSize: 30,
        color: lightPrimaryTextColor,
      ),
    ),
    textTheme: _buildTextTheme(Brightness.light),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: lightButtonColor,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: lightIconColor,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: lightIconColor,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
  );

  // Tema Oscuro
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: darkBackgroundColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    cardColor: darkCardColor,
    appBarTheme: AppBarTheme(
      color: darkBackgroundColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: darkIconColor),
      titleTextStyle: GoogleFonts.bebasNeue(
        fontSize: 30,
        color: darkPrimaryTextColor,
      ),
    ),
    textTheme: _buildTextTheme(Brightness.dark),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: darkButtonColor,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: darkIconColor,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: darkIconColor,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
  );

  // Función para construir TextTheme
  static TextTheme _buildTextTheme(Brightness brightness) {
    Color primaryTextColor = brightness == Brightness.light ? lightPrimaryTextColor : darkPrimaryTextColor;
    Color secondaryTextColor = brightness == Brightness.light ? lightSecondaryTextColor : darkSecondaryTextColor;

    return TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        color: primaryTextColor,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        color: secondaryTextColor,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        color: secondaryTextColor,
      ),
    );
  }
}
