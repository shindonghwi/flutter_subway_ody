import 'package:json_annotation/json_annotation.dart';

part 'SubwayErrorMessage.g.dart';

@JsonSerializable()
class SubwayErrorMessage {

  final int status;
  final String code;
  final String message;
  final String link;
  final String developerMessage;
  final int total;

  SubwayErrorMessage({
    required this.status,
    required this.code,
    required this.message,
    required this.link,
    required this.developerMessage,
    required this.total,
  });

  factory SubwayErrorMessage.fromJson(Map<String, dynamic> json) => _$SubwayErrorMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SubwayErrorMessageToJson(this);

}


