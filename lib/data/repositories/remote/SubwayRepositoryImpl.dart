import 'package:get_it/get_it.dart';
import 'package:subway_ody/data/data_source/remote/SubwayApi.dart';
import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/remote/subway/SubwayResponse.dart';
import 'package:subway_ody/domain/repositories/remote/SubwayRepository.dart';

class SubwayRepositoryImpl implements SubwayRepository {
  SubwayRepositoryImpl();

  @override
  Future<ApiResponse<SubwayResponse>> getRealTimeStationArrival(String subwayName) async {
    SubwayApi subwayApi = GetIt.instance<SubwayApi>();
    return await subwayApi.getRealTimeStationInfo(subwayName);
  }
}
