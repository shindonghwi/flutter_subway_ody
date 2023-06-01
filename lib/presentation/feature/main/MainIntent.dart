import 'package:subway_ody/presentation/feature/main/models/SubwayModel.dart';

class MainIntent{
  final String userRegion;
  final List<SubwayModel> subwayItems;

  MainIntent({
    required this.userRegion,
    required this.subwayItems,
  });
}