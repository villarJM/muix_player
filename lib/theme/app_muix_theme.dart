import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/shared_preferences/preferences_app_theme.dart';

class AppMuixTheme extends ChangeNotifier{

  static bool _isDarkMode = false;
  bool isDarkMode;
  ThemeData currentTheme;

  AppMuixTheme({
    required bool enabledDarkMode
  }) : isDarkMode = enabledDarkMode, currentTheme = enabledDarkMode ? darkTheme : lightTheme;

  setDarkMode() {
    isDarkMode = true;
    currentTheme = darkTheme;

    notifyListeners();
  }

  setLightMode() {
    isDarkMode = false;
    currentTheme = lightTheme;

    notifyListeners();
  }

  static void refreshTheme() {
    _isDarkMode = PreferencesAppTheme.isDarkMode;
  }


  // Colores Light
  static const Color _lightBackground = Color.fromARGB(255, 228, 211, 182); //#E4D3B6
  static const Color _lightBackgroundSecondary = Color.fromARGB(255, 223, 217, 205); //#DFD9CD

  static const Color _lightPrimary = Color.fromARGB(255, 51, 46, 33); //#332E21 
  static const Color _lightSecondary = Color.fromARGB(255, 250, 160, 81); //#
  static const Color _lightTertiary = Color.fromARGB(255, 243, 202, 69); // Amarillo Lima PANTONE P 10-16 C #dfab00

  static const Color _lightRatingStars = Colors.green;


  // Colores Dark
  static const Color _darkBackground = Color(0xFF121212);

  static const Color _darkPrimary = Color.fromARGB(255, 73, 92, 131 ); // Rojo Sangrita PANTONE P 55-8 C #e5133a
  static const Color _darkSecondary = Color.fromARGB(255, 122, 134, 182); // Naranja medio PANTONE P 27-8 C #ef7911
  static const Color _darkTertiary = Color.fromARGB(255, 168, 164, 206); // Amarillo Lima PANTONE P 10-16 C #dfab00

  static const Color _darkRatingStars = Colors.lightGreenAccent;

  // Color del lienzo
  static Color get background => _isDarkMode ? _darkBackground : _lightBackground;
  // Color del lienzo
  static Color get backgroundSecondary => _isDarkMode ? _darkBackground : _lightBackgroundSecondary;

  //Color de las figuras
  // static Color get linearGradientColor1 => _isDarkMode ? _lightSphereBottom1 

  // Colores de fondo componentes 
  static Color get backgroundWidget => _isDarkMode ? const Color.fromARGB(255, 66, 66, 66) : Colors.white;

  // Colores principales degradado
  static Color get primary => _isDarkMode ? _darkPrimary : _lightPrimary;
  static Color get secondary => _isDarkMode ? _darkSecondary : _lightSecondary;
  static Color get tertiary => _isDarkMode ? _darkTertiary : _lightTertiary;

  // Colores de texto
  static Color get textPrimary => primary;
  static Color get textColor => _isDarkMode ? Colors.white : Colors.black87;
  static Color get textColorOpaque => Colors.black54;

  // Colores de estrellas 
  static Color get ratingStars => _isDarkMode ? _darkRatingStars : _lightRatingStars;


  static List<Color> get gradientColors => [
    primary,
    secondary,
  ];

  // Títulos color primario Regular

  static TextStyle get textTitleUrbanistRegular36 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 36.sp,
    fontWeight: FontWeight.normal
  );

  // Texto normal color primario Medium

  static TextStyle get textUrbanistMediumPrimary11 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500
  );

  static TextStyle get textUrbanistMediumPrimary12 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500
  );

  static TextStyle get textUrbanistMediumPrimary24 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500
  );

  static TextStyle get textUrbanistMediumPrimary32 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 32.sp,
    fontWeight: FontWeight.w600
  );

  // Texto normal color primario SemiBold

  static TextStyle get textUrbanistSemiBoldPrimary32 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 32.sp,
    fontWeight: FontWeight.w800
  );

  static TextStyle get textUrbanistSemiBoldPrimary20 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 20.sp,
    fontWeight: FontWeight.w800
  );
  // Texto normal Medium
  static TextStyle get textUrbanistMedium12 => TextStyle(
    fontFamily: 'Urbanist',
    color: Colors.white,
    fontSize: 12.sp,
    fontWeight: FontWeight.normal
  );

  // Texto normal Bold
  static TextStyle get textUrbanistBold15 => TextStyle(
    fontFamily: 'Urbanist',
    color: textPrimary,
    fontSize: 15.sp,
    fontWeight: FontWeight.bold
  );
  
  static TextStyle get textClassicBlack16 => TextStyle(
    fontFamily: 'Alata',
    color: textColor,
    fontSize: 16.sp,
  );
  
  static TextStyle get textClassicBlack14 => TextStyle(
    fontFamily: 'Alata',
    color: textColor,
    fontSize: 14.sp,
  );

  // Texto normal color opaco
  static TextStyle get textOpaque20 => TextStyle(
    fontFamily: 'Alata',
    color: textColorOpaque,
    fontSize: 20.sp,
  );
  
  static TextStyle get textOpaque18 => TextStyle(
    fontFamily: 'Alata',
    color: textColorOpaque,
    fontSize: 18.sp,
  );
  
  static TextStyle get textOpaque16 => TextStyle(
    fontFamily: 'Alata',
    color: textColorOpaque,
    fontSize: 16.sp,
  );
  
  static TextStyle get textOpaque14 => TextStyle(
    fontFamily: 'Alata',
    color: textColorOpaque,
    fontSize: 14.sp,
  );

  // Texto normal en ambos modo
  static TextStyle get textNormal14 => const TextStyle(
    fontFamily: 'Alata',
    color: Colors.white,
    fontSize: 14,
  );

  static TextStyle get textNormal16 => const TextStyle(
    fontFamily: 'Alata',
    color: Colors.white,
    fontSize: 16,
  );

  static TextStyle get textNormal18 => const TextStyle(
    fontFamily: 'Alata',
    color: Colors.white,
    fontSize: 18,
  );

  // Texto normal en ambos modo color verde
  static TextStyle get textNormalGreen18 => const TextStyle(
    fontFamily: 'Alata',
    color: Colors.green,
    fontSize: 18,
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
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(primary),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      helperStyle: TextStyle(
          color: AppMuixTheme.primary,
          fontSize: 14,
          fontFamily: 'GOTHAMHTF',
          letterSpacing: -0.4),
      hintStyle: TextStyle(color: AppMuixTheme.primary, fontSize: 14),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppMuixTheme
                .primary, // Aquí puedes cambiar el color del borde
          ),
          borderRadius: BorderRadius.circular(8.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppMuixTheme
                .primary, // Aquí puedes cambiar el color del borde
          ),
          borderRadius: BorderRadius.circular(8.0)),
    ),
  );

  static final darkTheme = ThemeData.light().copyWith(
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
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(primary),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      helperStyle: TextStyle(
          color: AppMuixTheme.primary,
          fontSize: 14,
          fontFamily: 'GOTHAMHTF',
          letterSpacing: -0.4),
      hintStyle: TextStyle(color: AppMuixTheme.primary, fontSize: 14),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppMuixTheme
                .primary, // Aquí puedes cambiar el color del borde
          ),
          borderRadius: BorderRadius.circular(8.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppMuixTheme
                .primary, // Aquí puedes cambiar el color del borde
          ),
          borderRadius: BorderRadius.circular(8.0)),
    ),
  );
}
