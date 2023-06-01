import 'package:subway_ody/domain/models/remote/subway/SubwayRealTimeArrival.dart';
import 'package:subway_ody/presentation/feature/main/models/NearByStation.dart';
import 'package:subway_ody/presentation/feature/main/models/SubwayDirectionMessage.dart';

class SubwayModel {
  final NearByStation nearByStation; // 홍대입구, 500
  final List<SubwayRealTimeArrival> subwayArrivalList;

  SubwayModel({
    required this.nearByStation,
    required this.subwayArrivalList,
  });
}
