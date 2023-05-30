import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:subway_ody/app/env/Environment.dart';
import 'package:subway_ody/domain/models/LatLng.dart';
import 'package:subway_ody/domain/models/kakao/KakaoLocationResponse.dart';

class KakaoApi {
  KakaoApi();

  Map<String, String> headers = {
    'Accept-Language': 'ko-KR',
    'Accept': '*/*',
    'Connection': 'keep-alive',
    'Content-Type': 'application/json',
  };

  /// 위치 권한 요청
  Future<KakaoLocationResponse> getRegion(LatLng latLng) async {
    final params = {
      'x': latLng.longitude.toString(),
      'y': latLng.latitude.toString(),
    };

    headers['Authorization'] = 'KakaoAK ${Environment.kakaoRestApiKey}';

    final uri = Uri.https(
      'dapi.kakao.com',
      '/v2/local/geo/coord2regioncode.json',
      params,
    );

    debugPrint('request Url: $uri');

    final res = await http.get(
      uri,
      headers: headers,
    );
    debugPrint('response statusCode: ${res.statusCode}');
    debugPrint('response body: ${res.body}');
    debugPrint('response headers: ${res.headers}');

    return KakaoLocationResponse.fromJson(jsonDecode(res.body));
  }
}
