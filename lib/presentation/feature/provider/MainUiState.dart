import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subway_ody/presentation/models/UiState.dart';

final mainUiStateProvider = StateNotifierProvider<MainUiStateNotifier, UIState<String?>>(
  (_) => MainUiStateNotifier(),
);

class MainUiStateNotifier extends StateNotifier<UIState<String?>> {
  MainUiStateNotifier() : super(Loading());

  void changeUiState(UIState<String?> s) => state = s;
}
