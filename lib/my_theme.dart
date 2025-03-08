import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';

class MyTheme {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color primaryColor,
    required Color scaffoldBackgroundColor,
    required Color selectedItemColor,
    required Color unselectedItemColor,
    required Color iconColor,
    required Color textColor,
  }) {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: iconColor),
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unselectedItemColor,
      ),
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
      ),
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        errorStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      fontFamily: 'Lora',
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(color: textColor),
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.whiteColor,
    selectedItemColor: AppColors.secondary,
    unselectedItemColor: AppColors.thirdMintGreen,
    iconColor: AppColors.thirdMintGreen,
    textColor: AppColors.whiteColor,
  );

  static ThemeData get darkTheme => createTheme(
    brightness: Brightness.dark,
    primaryColor: AppColors.fifthColor,
    scaffoldBackgroundColor: AppColors.blackColor,
    selectedItemColor: AppColors.secondary,
    unselectedItemColor: AppColors.whiteColor,
    iconColor: AppColors.thirdMintGreen,
    textColor: AppColors.whiteColor
  );
}
