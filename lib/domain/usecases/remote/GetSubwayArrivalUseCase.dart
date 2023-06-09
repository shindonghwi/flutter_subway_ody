import 'package:get_it/get_it.dart';
import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/remote/subway/SubwayResponse.dart';
import 'package:subway_ody/domain/repositories/remote/SubwayRepository.dart';
import 'package:subway_ody/firebase/Analytics.dart';

class GetSubwayArrivalUseCase {
  GetSubwayArrivalUseCase();

  final SubwayRepository _subwayRepository = GetIt.instance<SubwayRepository>();

  Future<ApiResponse<SubwayResponse>> call(String subwayName) async {
    final res = await _subwayRepository.getRealTimeStationArrival(removeEndingStation(subwayName));
    res.data?.realtimeArrivalList?.forEach((element) {
      Analytics.eventFavoriteSubwayName(element.statnNm);
      Analytics.eventFavoriteSubwayLine(element.subwayId);
    });
    return res;
  }

  String removeEndingStation(String str) {
    if (str.endsWith("역")) {
      return str.substring(0, str.length - 1); // 마지막 글자 "역"을 제거한 문자열 반환
    }
    return str; // "역"로 끝나지 않을 경우 그대로 반환
  }
}
