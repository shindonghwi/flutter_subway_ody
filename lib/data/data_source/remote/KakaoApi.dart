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
// 우이신설 - 봉은사
// final x = "127.0601";
// final y = "37.5142";
// // 우이신설 - 개화
// final x = "126.7951";
// final y = "37.5778";
// // 우이신설 - 김포공항
final x = "126.8106";
final y = "37.5636";



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
