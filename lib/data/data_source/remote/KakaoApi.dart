import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:subway_ody/app/env/Environment.dart';
import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/LatLng.dart';
import 'package:subway_ody/domain/models/kakao/KakaoLocationResponse.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class KakaoApi {
  KakaoApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  Map<String, String> headers = {
    'Accept-Language': 'ko-KR',
    'Accept': '*/*',
    'Connection': 'keep-alive',
    'Content-Type': 'application/json',
  };

  parseFixNumber(String numberString) {
    final double number = double.parse(numberString);
    final String formattedNumber = number.toStringAsFixed(3);
    return formattedNumber;
  }

  /// 위치 권한 요청
  Future<ApiResponse<KakaoLocationResponse>> getRegion(LatLng latLng) async {
    final params = {
      'x': parseFixNumber(latLng.longitude.toString()),
      'y': parseFixNumber(latLng.latitude.toString()),
    };

    headers['Authorization'] = 'KakaoAK ${Environment.kakaoRestApiKey}';
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
}

bool isJson(String jsonString) {
  try {
    jsonDecode(jsonString);
    return true;
  } catch (e) {
    return false;
  }
}
