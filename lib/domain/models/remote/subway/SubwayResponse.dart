import 'package:json_annotation/json_annotation.dart';

import 'SubwayErrorMessage.dart';
import 'SubwayRealTimeArrival.dart';

part 'SubwayResponse.g.dart';

@JsonSerializable()
class SubwayResponse {

  final int? status;
  final String? code;
  final String? message;
  final String? link;
  final String? developerMessage;
  final int? total;

  SubwayErrorMessage? errorMessage;
  List<SubwayRealTimeArrival>? realtimeArrivalList;

  SubwayResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.link,
    required this.developerMessage,
    required this.total,
    required this.errorMessage,
    required this.realtimeArrivalList,
  });

  factory SubwayResponse.fromJson(Map<String, dynamic> json) => _$SubwayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubwayResponseToJson(this);

}


