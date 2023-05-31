import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/LatLng.dart';
import 'package:subway_ody/domain/models/kakao/KakaoLocationResponse.dart';

abstract class KakaoGpsRepository {
  Future<ApiResponse<KakaoLocationResponse>> getRegion(LatLng latLng); // location 권한 요청
}
