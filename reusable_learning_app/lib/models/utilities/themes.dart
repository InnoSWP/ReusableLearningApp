import 'package:flutter/material.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';

class AppThemes {
  static final darkTheme = ThemeData(
    canvasColor: CustomColors.appBarDark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: const ColorScheme.dark(),
    appBarTheme: const AppBarTheme(
      backgroundColor: CustomColors.appBarDark
    ),
    cardTheme: const CardTheme(
      color: CustomColors.appBarDark,
    ),
    textTheme: TextTheme(
      /// Course Card title textStyle
      titleMedium: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),

      /// Course Card button textStyle
      titleSmall: const TextStyle(
        color: CustomColors.purpleDark,
        fontSize: 16,
      ),

      /// Course Card description textStyle
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade400,
        height: 1.3
      ),
      labelSmall: TextStyle(
        fontSize: 17,
        color: Colors.grey.shade400,
        letterSpacing: 0
      )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: CustomColors.appBarDark
    ),
    iconTheme: const IconThemeData(
      color: CustomColors.purpleDark
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: CustomColors.appBarDark
    ),

    snackBarTheme: const SnackBarThemeData(
      backgroundColor: CustomColors.appBarDark,
      contentTextStyle: TextStyle(
        color: Colors.white,
      ),
    )
  );
  static final lightTheme = ThemeData(
    canvasColor: CustomColors.purple,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    appBarTheme: const AppBarTheme(
        backgroundColor: CustomColors.purple
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      /// Course Card title textStyle
      titleMedium: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold
      ),
      /// Course Card button textStyle
      titleSmall: const TextStyle(
          color: CustomColors.purple,
          fontSize: 16,
      ),
      /// Course Card description textStyle
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade700,
        height: 1.3
      ),
      labelSmall: const TextStyle(
        fontSize: 17,
        color: CustomColors.grey,
        letterSpacing: 0
      )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: CustomColors.purple
    ),
    iconTheme: const IconThemeData(
        color: CustomColors.purple
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: CustomColors.appBarDark,
      contentTextStyle: TextStyle(
        color: Colors.white,
      ),
    )

  );
}