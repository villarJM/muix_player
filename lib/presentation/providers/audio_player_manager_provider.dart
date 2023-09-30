import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_audio_query/on_audio_query.dart';

// icon
final isIconPlayer = StateProvider((ref) => false);

final iconPlayerChange = StateProvider((ref) => Icons.play_arrow_rounded);

final listSongProvider = StateProvider<List<SongModel>>((ref) => []);