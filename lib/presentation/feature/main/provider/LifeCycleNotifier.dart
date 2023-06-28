import 'package:riverpod/riverpod.dart';

final lifeCycleProvider = StateNotifierProvider<LifeCycleNotifier, bool>(
  (_) => LifeCycleNotifier(),
);

class LifeCycleNotifier extends StateNotifier<bool> {
  LifeCycleNotifier() : super(false);

  void setMode(bool mode) => state = mode;
}
