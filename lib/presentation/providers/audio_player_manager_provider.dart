import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// icon
final isIconPlayer = StateProvider((ref) => false);

final iconPlayerChange = StateProvider((ref) => Icons.play_arrow_rounded);