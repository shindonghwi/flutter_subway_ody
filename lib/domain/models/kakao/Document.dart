import 'package:json_annotation/json_annotation.dart';
import 'package:subway_ody/domain/models/kakao/DocumentAddress.dart';
import 'package:subway_ody/domain/models/kakao/DocumentRoadAddress.dart';

part 'Document.g.dart';

@JsonSerializable()
class Document {
  DocumentRoadAddress? road_address;
  DocumentAddress? address;
  String place_name;

  Document({
    required this.road_address,
    required this.address,
    required this.place_name,
  });

  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);

}


