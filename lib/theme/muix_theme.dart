
import 'package:flutter/material.dart';

class MuixTheme extends ChangeNotifier {

  final Color _colorWhite = Colors.white;

  Color get colorWhite => _colorWhite;

  TextStyle get styleUrbanist36WhiteW500 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 36,
    color: _colorWhite,
    fontWeight: FontWeight.w500
  );

  TextStyle get styleUrbanist24WhiteW500 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 24,
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