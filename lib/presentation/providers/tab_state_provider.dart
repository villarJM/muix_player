import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tab_state_provider.g.dart';

@Riverpod(keepAlive: true)
class TabStateProvider extends _$TabStateProvider {

  @override
  bool build() {
    return false;
  }

  void isSelected(bool selected) {
    state = selected;
  }
  
}