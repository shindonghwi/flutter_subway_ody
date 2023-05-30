import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/models/LatLng.dart';
import 'package:subway_ody/domain/models/kakao/KakaoLocationResponse.dart';
import 'package:subway_ody/domain/repositories/remote/KakaoGpsRepository.dart';

class GetKakaoLatlngToRegionUseCase {
  GetKakaoLatlngToRegionUseCase();

  final KakaoGpsRepository _kakaoGpsRepository = GetIt.instance<KakaoGpsRepository>();

  Future<KakaoLocationResponse> call(LatLng latLng) async {
    return await _kakaoGpsRepository.getRegion(latLng);
  }
}
