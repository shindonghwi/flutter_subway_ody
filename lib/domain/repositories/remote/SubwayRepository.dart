import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/remote/subway/SubwayResponse.dart';

abstract class SubwayRepository {
  Future<ApiResponse<SubwayResponse>> getRealTimeStationArrival(String subwayName); // 실시간 지하철 도착 정보
}
