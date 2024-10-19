
import 'package:flutter/material.dart';

class MuixTheme extends ChangeNotifier {

  Color _colorWhite = Colors.white;

  Color get colorWhite => _colorWhite;

  TextStyle get styleUrbanist36WhiteW500 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 36,
    color: _colorWhite,
    fontWeight: FontWeight.w500
  );

}