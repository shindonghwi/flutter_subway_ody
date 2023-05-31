import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/LatLng.dart';
import 'package:subway_ody/domain/models/kakao/KakaoLocationResponse.dart';

abstract class KakaoGpsRepository {
  Future<ApiResponse<KakaoLocationResponse>> getRegion(LatLng latLng); // location 권한 요청

  Future<ApiResponse<KakaoLocationResponse>> getNearBySubwayStation(LatLng latLng, int distance); // 가까운 지하철 역 찾기
}
