import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interactive_color_state_provider.g.dart';

@Riverpod(keepAlive: true)
class InteractiveColor extends _$InteractiveColor {
  @override
  Color build() => Color(0XFF404094);

  void dominatingColor(Color color) => state = color;
}