import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:typed_data';

part 'interactive_background_image_state.g.dart';

@Riverpod(keepAlive: true)
class InteractiveBackgroundImage extends _$InteractiveBackgroundImage {
  @override
  Uint8List build() => Uint8List.fromList([]);

  void getImage(Uint8List image) => state = image;
}