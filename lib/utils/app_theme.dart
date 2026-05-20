import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(

    scaffoldBackgroundColor:
    const Color(0xFFF4F7FB),

    primaryColor: AppColors.primary,

    textTheme: GoogleFonts.poppinsTextTheme(),

    appBarTheme: AppBarTheme(

      backgroundColor: Colors.transparent,

      elevation: 0,

      centerTitle: true,

      foregroundColor: AppColors.textDark,

      titleTextStyle: GoogleFonts.poppins(
        color: AppColors.textDark,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),

    ),

    elevatedButtonTheme:

    ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(

        backgroundColor: AppColors.primary,

        foregroundColor: Colors.white,

        elevation: 0,

        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),

        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(18),
        ),

      ),

    ),

  );

}