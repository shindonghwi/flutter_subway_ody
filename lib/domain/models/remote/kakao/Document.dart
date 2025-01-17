import 'package:json_annotation/json_annotation.dart';

import 'DocumentAddress.dart';
import 'DocumentRoadAddress.dart';

part 'Document.g.dart';

@JsonSerializable()
class Document {
  DocumentRoadAddress? road_address;
  DocumentAddress? address;
  String? place_name;
  String? distance;
  String? x;
  String? y;

  Document({
    required this.road_address,
    required this.address,
    required this.place_name,
    required this.distance,
    required this.x,
    required this.y,
  });

  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);

}


