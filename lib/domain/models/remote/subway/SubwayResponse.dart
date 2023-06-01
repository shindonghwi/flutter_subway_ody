import 'package:json_annotation/json_annotation.dart';

import 'SubwayErrorMessage.dart';
import 'SubwayRealTimeArrival.dart';

part 'SubwayResponse.g.dart';

@JsonSerializable()
class SubwayResponse {
  SubwayErrorMessage? errorMessage;
  List<SubwayRealTimeArrival>? realtimeArrivalList;

  SubwayResponse({
    required this.errorMessage,
    required this.realtimeArrivalList,
  });

  factory SubwayResponse.fromJson(Map<String, dynamic> json) => _$SubwayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubwayResponseToJson(this);

}


