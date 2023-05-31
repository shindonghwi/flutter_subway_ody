import 'package:get_it/get_it.dart';
import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/LatLng.dart';
import 'package:subway_ody/domain/models/kakao/KakaoLocationResponse.dart';
import 'package:subway_ody/domain/repositories/remote/KakaoGpsRepository.dart';

class GetNearBySubwayStationUseCase {
  GetNearBySubwayStationUseCase();

  final KakaoGpsRepository _kakaoGpsRepository = GetIt.instance<KakaoGpsRepository>();

  Future<ApiResponse<KakaoLocationResponse>> call(LatLng latLng, int distance) async {
    return await _kakaoGpsRepository.getNearBySubwayStation(latLng, distance);
  }
}
