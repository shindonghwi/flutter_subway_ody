import 'package:riverpod/riverpod.dart';

final autoRefreshProvider = StateNotifierProvider<AutoRefreshNotifier, bool>(
  (_) => AutoRefreshNotifier(),
);

class AutoRefreshNotifier extends StateNotifier<bool> {
  AutoRefreshNotifier() : super(false);

  void setMode(bool mode) => state = mode;
}
