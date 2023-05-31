import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:subway_ody/data/data_source/local/LocalGpsApi.dart';
import 'package:subway_ody/data/data_source/remote/KakaoApi.dart';
import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/LatLng.dart';
import 'package:subway_ody/domain/models/kakao/KakaoLocationResponse.dart';
import 'package:subway_ody/domain/repositories/local/LocalGpsRepository.dart';
import 'package:subway_ody/domain/repositories/remote/KakaoGpsRepository.dart';

class KakaoGpsRepositoryImpl implements KakaoGpsRepository {
  KakaoGpsRepositoryImpl();

  @override
  Future<ApiResponse<KakaoLocationResponse>> getRegion(LatLng latLng) async{
    KakaoApi kakaoApi = GetIt.instance<KakaoApi>();
    return await kakaoApi.getRegion(latLng);
  }

}
