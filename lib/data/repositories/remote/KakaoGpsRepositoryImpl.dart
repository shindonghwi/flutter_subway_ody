import 'package:get_it/get_it.dart';
import 'package:subway_ody/data/data_source/remote/KakaoApi.dart';
import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/domain/models/remote/kakao/KakaoLocationResponse.dart';
import 'package:subway_ody/domain/repositories/remote/KakaoGpsRepository.dart';

class KakaoGpsRepositoryImpl implements KakaoGpsRepository {
  KakaoGpsRepositoryImpl();

  @override
  Future<ApiResponse<KakaoLocationResponse>> getRegion(LatLng latLng) async {
    KakaoApi kakaoApi = GetIt.instance<KakaoApi>();
    return await kakaoApi.getRegion(latLng);
  }

  @override
  Future<ApiResponse<KakaoLocationResponse>> getNearBySubwayStation(
    LatLng latLng,
    int distance,
  ) async {
    KakaoApi kakaoApi = GetIt.instance<KakaoApi>();
    return await kakaoApi.getNearBySubwayStation(latLng, distance);
  }
}
