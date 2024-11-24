
import 'package:flutter/material.dart';

class MuixTheme extends ChangeNotifier {

  final Color _colorWhite = Colors.white;

  Color get colorWhite => _colorWhite;

  TextStyle get stPop48WhtW900 => TextStyle(
    color: _colorWhite, 
    fontSize: 48, fontWeight: FontWeight.w900, 
    fontFamily: 'Poppins',
    height: 1.1,
    overflow: TextOverflow.ellipsis 
  );

  TextStyle get styleUrbanist36WhiteW500 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 36,
    color: _colorWhite,
    fontWeight: FontWeight.w500
  );

  TextStyle get stPop30WhtW900 => TextStyle(
    color: _colorWhite, 
    fontSize: 30, fontWeight: FontWeight.w900, 
    fontFamily: 'Poppins',
    height: 1.1,
    overflow: TextOverflow.ellipsis,
    letterSpacing: 2
  );

  TextStyle get styleUrbanist24WhiteW500 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 24,
    color: _colorWhite,
    fontWeight: FontWeight.w500
  );

  TextStyle get styleUrbanist20WhiteW700 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 20,
    color: _colorWhite,
    fontWeight: FontWeight.bold,
    overflow: TextOverflow.ellipsis,
  );

  TextStyle get stPop20WhtW700 => TextStyle(
    color: _colorWhite, 
    fontSize: 20, 
    fontWeight: FontWeight.bold, 
    fontFamily: 'Poppins',
  );

  TextStyle get styleUrbanist16WhiteW700 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 16,
    color: _colorWhite,
    fontWeight: FontWeight.bold
  );

  TextStyle get styleUrbanist16WhiteW500 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 16,
    color: _colorWhite,
    fontWeight: FontWeight.w500
  );

  TextStyle get styleUrbanist12WhiteW600 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 12,
    color: _colorWhite,
    fontWeight: FontWeight.w600,
    overflow: TextOverflow.ellipsis
  );

  TextStyle get styleUrbanist11WhiteW600 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 11,
    color: _colorWhite,
    fontWeight: FontWeight.w600
  );

}