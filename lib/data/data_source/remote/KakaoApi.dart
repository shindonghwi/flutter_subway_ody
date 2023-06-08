import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:subway_ody/app/env/Environment.dart';
import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/local/LatLng.dart';
import 'package:subway_ody/domain/models/remote/kakao/KakaoLocationResponse.dart';
import 'package:subway_ody/presentation/utils/Common.dart';


// // 신분당 - 광교
// final x = "127.0441";
// final y = "37.3018";
// // 신분당 - 신사
// final x = "127.0198";
// final y = "37.5161";

// // 공항 - 서울역
// final x = "126.9727";
// final y = "37.5528";
// // 공항 - 인천 공항 2터미널
// final x = "126.4321";
// final y = "37.4677";

// // 경의중앙 - 지평
// final x = "127.6294";
// final y = "37.4766";
// // 경의중앙 - 신촌
// final x = "126.9424";
// final y = "37.5597";
// 경의중앙 - 가좌
// final x = "126.9143";
// final y = "37.5689";
// // 경의중앙 - 디지털 미디어시티
// final x = "126.8997";
// final y = "37.5779";
// // 경의중앙 - 백마
// final x = "126.7946";
// final y = "37.6579";
// // 경의중앙 - 용문
// final x = "127.5940";
// final y = "37.4822";

// // 경춘선 - 청량리
// final x = "127.0451";
// final y = "37.5802";
// // 경춘선 - 광운대
// final x = "127.0617";
// final y = "37.6238";
// // 경춘선 - 상봉
// final x = "127.0850";
// final y = "37.5968";
// // 경춘선 - 신내
// final x = "127.1032";
// final y = "37.6127";
// // 경춘선 - 춘천
// final x = "127.7168";
// final y = "37.8847";
// // 경춘선 - 남춘천
// final x = "127.7240";
// final y = "37.8637";

// //수인분당 - 청량리
// final x = "127.0475";
// final y = "37.5804";
// // 수인분당- 인천
// final x = "126.6174";
// final y = "37.4763";
// 수인분당 - 매교
// final x = "127.0159";
// final y = "37.2654";

// // 우이신설 - 신설동
// final x = "127.0232";
// final y = "37.5757";
// 우이신설 - 화계
// final x = "127.0173";
// final y = "37.6340";
// // 우이신설 - 북한산우이
// final x = "127.0125";
// final y = "37.6630";

// // 9호선 - 중앙보훈병원
// final x = "127.1484";
// final y = "37.5285";
// 9호선 - 봉은사
// final x = "127.0601";
// final y = "37.5142";
// // 9호선 - 개화
// final x = "126.7951";
// final y = "37.5778";
// // 9호선 - 김포공선
// final x = "126.8106";
// final y = "37.5636";

// // 8호선 - 암사역
// final x = "127.1273";
// final y = "37.5491";
// 8호선 - 천호
// final x = "127.1237";
// final y = "37.5385";
// // 8호선 - 모란
// final x = "127.1292";
// final y = "37.4338";
// // 8호선 - 단대오거리
// final x = "127.1566";
// final y = "37.4450";

// // 7호선 - 장암
// final x = "127.0524";
// final y = "37.6998";
// 7호선 - 군자
// final x = "127.0794";
// final y = "37.5573";
// // 7호선 - 상동
// final x = "126.7532";
// final y = "37.5058";
// // 7호선 - 석남
// final x = "126.6762";
// final y = "37.5063";

// // 6호선 - 신내
// final x = "127.1033";
// final y = "37.6128";
// 6호선 - 화랑대
// final x = "127.0836";
// final y = "37.6200";
// // 6호선 - 새절
// final x = "126.9135";
// final y = "37.5909";
// // 6호선 - 응암
// final x = "126.9156";
// final y = "37.5985";
// // 6호선 - 구산
// final x = "126.9171";
// final y = "37.6112";
// // 6호선 - 불광
// final x = "126.9295";
// final y = "37.6111";

// // 5호선 - 방화
// final x = "126.8127";
// final y = "37.5775";
// 5호선 - 여의도
// final x = "126.9243";
// final y = "37.5217";
// // 5호선 - 천호
// final x = "127.1236";
// final y = "37.5386";
// // 5호선 - 강동
// final x = "127.1323";
// final y = "37.5359";
// // 5호선 - 길동
// final x = "127.1399";
// final y = "37.5380";
// // 5호선 - 둔촌동
// final x = "127.1362";
// final y = "37.5277";
// // 5호선 - 하남검단산
// final x = "127.2233";
// final y = "37.5398";
// // 5호선 - 마천
// final x = "127.1527";
// final y = "37.4948";

// // 4호선 - 당고개
// final x = "127.0791";
// final y = "37.6703";
//4호선 - 혜화
// final x = "127.0019";
// final y = "37.5821";
// // 4호선 - 오이도
// final x = "126.7387";
// final y = "37.3617";
// // 4호선 - 신길온천
// final x = "126.7672";
// final y = "37.3376";

// // 3호선 - 오금
// final x = "127.1282";
// final y = "37.5018";
// 3호선 - 수서
// final x = "127.1018";
// final y = "37.4875";
// // 3호선 - 대화
// final x = "126.7475";
// final y = "37.6762";
// // 3호선 - 주엽
final x = "126.7615";
final y = "37.6702";



class KakaoApi {
  KakaoApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  Map<String, String> headers = {
    'Accept-Language': 'ko-KR',
    'Accept': '*/*',
    'Connection': 'keep-alive',
    'Content-Type': 'application/json',
    'Authorization': 'KakaoAK ${Environment.kakaoRestApiKey}',
  };

  parseFixNumber(String numberString) {
    final double number = double.parse(numberString);
    final String formattedNumber = number.toStringAsFixed(4);
    return formattedNumber;
  }

  /// 위치 권한 요청
  Future<ApiResponse<KakaoLocationResponse>> getRegion(LatLng latLng) async {
    final params = {
      // 'x': parseFixNumber(latLng.longitude.toString()),
      // 'y': parseFixNumber(latLng.latitude.toString()),
      'x': x,
      'y': y,
    };

    final uri = Uri.https(
      'dapi.kakao.com',
      '/v2/local/geo/coord2address.json',
      params,
    );

    debugPrint('request Url: $uri');

    final response = await http.get(uri, headers: headers);
    debugPrint('response auth: ${Environment.kakaoRestApiKey}');
    debugPrint('response statusCode: ${response.statusCode}');
    debugPrint('response body: ${response.body}');
    debugPrint('response headers: ${response.headers}');

    if (response.statusCode >= 500) {
      return ApiResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_server_error_5xx,
        data: null,
      );
    } else {
      return ApiResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_api_success,
        data: KakaoLocationResponse.fromJson(
          jsonDecode(response.body),
        ),
      );
    }
  }

  /// 가까운 지하철역 구하기
  Future<ApiResponse<KakaoLocationResponse>> getNearBySubwayStation(LatLng latLng, int distance) async {
    final params = {
      // 'x': parseFixNumber(latLng.longitude.toString()),
      // 'y': parseFixNumber(latLng.latitude.toString()),
      'x': x,
      'y': y,
      'radius': distance.toString(),
      'query': '역',
      'category_group_code': 'SW8',
      'sort': 'distance',
    };

    final uri = Uri.https(
      'dapi.kakao.com',
      '/v2/local/search/keyword.json',
      params,
    );

    debugPrint('request url: $uri');
    debugPrint('request params: $params');

    final response = await http.get(uri, headers: headers);
    debugPrint('response auth: ${Environment.kakaoRestApiKey}');
    debugPrint('response statusCode: ${response.statusCode}');
    debugPrint('response body: ${response.body}');
    debugPrint('response headers: ${response.headers}');

    if (response.statusCode >= 500) {
      return ApiResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_server_error_5xx,
        data: null,
      );
    } else {
      return ApiResponse(
        status: response.statusCode,
        message: _getAppLocalization.get().message_api_success,
        data: KakaoLocationResponse.fromJson(
          jsonDecode(response.body),
        ),
      );
    }
  }
}
