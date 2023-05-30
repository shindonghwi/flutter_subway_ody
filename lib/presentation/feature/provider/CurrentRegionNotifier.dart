import 'package:riverpod/riverpod.dart';

final currentRegionProvider = StateNotifierProvider<CurrentRegionNotifier, String>(
  (_) => CurrentRegionNotifier(),
);

class CurrentRegionNotifier extends StateNotifier<String> {
  CurrentRegionNotifier() : super("");

  void setRegion(String region) => state = region;
}
