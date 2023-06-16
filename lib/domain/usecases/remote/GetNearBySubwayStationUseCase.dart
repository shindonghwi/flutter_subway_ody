import 'package:get_it/get_it.dart';
import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/domain/models/remote/kakao/KakaoLocationResponse.dart';
import 'package:subway_ody/domain/repositories/remote/KakaoGpsRepository.dart';
import 'package:subway_ody/domain/usecases/local/GetAppModeUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetDemoUserLatLngUseCase.dart';

class GetNearBySubwayStationUseCase {
  GetNearBySubwayStationUseCase();

  final KakaoGpsRepository _kakaoGpsRepository = GetIt.instance<KakaoGpsRepository>();

  Future<ApiResponse<KakaoLocationResponse>> call(LatLng latLng, int distance) async {
    LatLng reqLatLng = latLng;

    if (await GetIt.instance<GetAppModeUseCase>().call()) {
      final userLatLng = await GetIt.instance<GetDemoUserLatLngUseCase>().call();
      if (userLatLng != null){
        reqLatLng = userLatLng;
      }
    }
    return await _kakaoGpsRepository.getNearBySubwayStation(reqLatLng, distance);
  }
}
