import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:subway_ody/data/models/ApiResponse.dart';
import 'package:subway_ody/domain/models/remote/subway/SubwayResponse.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

import 'Service.dart';

class SubwayApi {
  SubwayApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  Map<String, String> headers = {
    'Accept-Language': 'ko-KR',
    'Accept': '*/*',
    'Connection': 'keep-alive',
    'Content-Type': 'application/json; charset=utf-8',
  };

  /// 실시간 지하철 도착정보
  Future<ApiResponse<SubwayResponse>> getRealTimeStationInfo(String subwayName) async {
    if (await Service.isNetworkAvailable()) {
      debugPrint('request Data: $subwayName');

      const key = '73637950736f726f313036514f647871';

      final uri = Uri.http(
        'swopenapi.seoul.go.kr',
        '/api/subway/$key/json/realtimeStationArrival/0/100/$subwayName',
      );

      final response = await http.get(uri, headers: headers);
      debugPrint('request Url: $uri');
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
        final body = SubwayResponse.fromJson(jsonDecode(response.body));
        debugPrint('response body: ${body.status == null}');
        debugPrint('response body: ${body.status == "null"}');
        debugPrint('response body: ${body.errorMessage?.status}');
        debugPrint('response body: ${body.status}');
        debugPrint('response body: ${body.status != null ? body.status! : body.errorMessage!.status}');
        return ApiResponse(
          status: body.status != null ? body.status! : body.errorMessage!.status,
          message: _getAppLocalization.get().message_api_success,
          data: body,
        );
      }
    } else {
      return ApiResponse(
        status: 406,
        message: _getAppLocalization.get().message_network_error,
        data: null,
      );
    }
  }
}
