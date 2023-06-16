import 'package:get_it/get_it.dart';
import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/domain/models/remote/kakao/KakaoLocationResponse.dart';
import 'package:subway_ody/domain/repositories/remote/KakaoGpsRepository.dart';
import 'package:subway_ody/domain/usecases/local/GetAppModeUseCase.dart';
import 'package:subway_ody/domain/usecases/local/GetDemoUserLatLngUseCase.dart';
import 'package:subway_ody/firebase/Analytics.dart';

class GetKakaoLatLngToRegionUseCase {
  GetKakaoLatLngToRegionUseCase();

  final KakaoGpsRepository _kakaoGpsRepository = GetIt.instance<KakaoGpsRepository>();

  Future<ApiResponse<KakaoLocationResponse>> call(LatLng latLng) async {
    LatLng reqLatLng = latLng;

    if (await GetIt.instance<GetAppModeUseCase>().call()) {
      final userLatLng = await GetIt.instance<GetDemoUserLatLngUseCase>().call();
      if (userLatLng != null){
        reqLatLng = userLatLng;
      }
    }

    final res = await _kakaoGpsRepository.getRegion(reqLatLng);

    res.data?.documents?.forEach((element) {
      Analytics.eventAddressDo(element.address?.region_1depth_name);
      Analytics.eventAddressGu(element.address?.region_2depth_name);
      Analytics.eventAddressDong(element.address?.region_3depth_name);
    });

    return res;
  }
}
