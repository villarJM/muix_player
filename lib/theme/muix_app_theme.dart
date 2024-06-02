import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MuixAppTheme extends ChangeNotifier {

  static bool isDarkMode = false;
  
  ThemeData get currentTheme => isDarkMode ? lightTheme : darkTheme;

  void setLightTheme() {
    isDarkMode = false;
    notifyListeners();
  }
  void setDarkTheme() {
    isDarkMode = true;
    notifyListeners();
  }

  void setCurrentTheme() {

  }

  // Light Colors
  static const Color _lightBackground = Color(0XFFE4D3B6);
  static const Color _lightBackgroundSecondary = Color(0XFFDFD9CD);

  static const Color _lightPrimary = Color(0XFF332E21);
  static const Color _lightSecondary = Color(0XFF000000);
  static const Color _lightTertiary = Color(0XFFFFFFFF);

  //Dark Colors
  static const Color _darkBackground = Color(0XFF000000);

  static const Color _darkPrimary = Color(0XFFE4D3B6);
  static const Color _darkSecondary = Color(0XFFFFFFFF);
  static const Color _darkTertiary = Color(0XFFFFFFFF);

  // Colors
  static Color get background => isDarkMode ? _darkBackground : _lightBackground;
  static Color get backgroundSecondary => isDarkMode ? _darkBackground : _lightBackgroundSecondary;

  static Color get primary => isDarkMode ? _darkPrimary : _lightPrimary;
  static Color get secondary => isDarkMode ? _darkSecondary : _lightSecondary;
  static Color get tertiary => isDarkMode ? _darkTertiary : _lightTertiary;

  //Colors Text
  static Color get textPrimary => primary;
  static Color get textSecondary => secondary;
  static Color get textTertiary => tertiary;

  //Title Color Primary Regular
  static TextStyle get titlePrimaryRegular36 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 36.sp,
    fontWeight: FontWeight.normal
  );

  static TextStyle get titlePrimaryRegular16 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 15.sp,
    fontWeight: FontWeight.normal
  );

  //Text Color Primary Medium
  static TextStyle get textPrimaryMedium11 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500
  );

  static TextStyle get textPrimaryMedium12 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500
  );

  static TextStyle get textPrimaryMedium24 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500
  );

  static TextStyle get textPrimaryMedium32 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 32.sp,
    fontWeight: FontWeight.w600
  );

  //Text Color Tertiary Medium
  static TextStyle get textTertiaryMedium15 => TextStyle(
    fontFamily: 'Urbanist',
    color: textTertiary,
    fontSize: 15.sp,
    fontWeight: FontWeight.normal
  );

  static TextStyle get textTertiaryMedium12 => TextStyle(
    fontFamily: 'Urbanist',
    color: textTertiary,
    fontSize: 12.sp,
    fontWeight: FontWeight.normal
  );

  //Title Color Primary SemiBold
  static TextStyle get textPrimarySemiBold32 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 32.sp,
    fontWeight: FontWeight.w800
  );

  static TextStyle get textPrimarySemiBold20 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 20.sp,
    fontWeight: FontWeight.w800
  );

  //Text Color Tertiary SemiBold
  static TextStyle get textTerTiarySemiBold32 => TextStyle(
    fontFamily: 'Urbanist',
    color: textTertiary,
    fontSize: 32.sp,
    fontWeight: FontWeight.w800
  );

  static TextStyle get textTertiarySemiBold20White => TextStyle(
    fontFamily: 'Urbanist',
    color: textTertiary,
    fontSize: 20.sp,
    fontWeight: FontWeight.w800
  );

  static TextStyle get textTertiaryMedium18White => TextStyle(
    fontFamily: 'Urbanist',
    color: textTertiary,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600
  );

  // Text Color Primary Bold
  static TextStyle get textPrimaryBold16 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 15.sp,
    fontWeight: FontWeight.bold
  );

  static TextStyle get textPrimaryBold15 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold
  );

  // Text Color Primary Bold
  static TextStyle get textTertiaryBold16 => TextStyle(
    fontFamily: 'Urbanist',
    color: textTertiary,
    fontSize: 15.sp,
    fontWeight: FontWeight.bold
  );

  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    platform: TargetPlatform.iOS,
    // AppBar Theme

    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    ),

    scaffoldBackgroundColor: _lightBackground,

    buttonTheme: ButtonThemeData(buttonColor: primary),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      helperStyle: TextStyle(
          color: MuixAppTheme.primary,
          fontSize: 14,
          fontFamily: 'GOTHAMHTF',
          letterSpacing: -0.4),
      hintStyle: TextStyle(color: MuixAppTheme.primary, fontSize: 14),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MuixAppTheme
                .primary, // Aquí puedes cambiar el color del borde
          ),
          borderRadius: BorderRadius.circular(8.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MuixAppTheme
                .primary, // Aquí puedes cambiar el color del borde
          ),
          borderRadius: BorderRadius.circular(8.0)),
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: primary,
    platform: TargetPlatform.iOS,
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    ),

    scaffoldBackgroundColor: _darkBackground,

    buttonTheme: ButtonThemeData(buttonColor: primary),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      helperStyle: TextStyle(
          color: MuixAppTheme.primary,
          fontSize: 14,
          fontFamily: 'GOTHAMHTF',
          letterSpacing: -0.4),
      hintStyle: TextStyle(color: MuixAppTheme.primary, fontSize: 14),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MuixAppTheme
                .primary, // Aquí puedes cambiar el color del borde
          ),
          borderRadius: BorderRadius.circular(8.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MuixAppTheme
                .primary, // Aquí puedes cambiar el color del borde
          ),
          borderRadius: BorderRadius.circular(8.0)),
    ),
  );

}