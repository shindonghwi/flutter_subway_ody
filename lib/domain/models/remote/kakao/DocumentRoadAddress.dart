
import 'package:json_annotation/json_annotation.dart';

part 'DocumentRoadAddress.g.dart';

@JsonSerializable()
class DocumentRoadAddress {
  String? address_name;
  String? region_1depth_name;
  String? region_2depth_name;
  String? region_3depth_name;
  String? road_name;
  String? underground_yn;
  String? main_building_no;
  String? sub_building_no;
  String? building_name;
  String? zone_no;


  DocumentRoadAddress({
    required this.address_name,
    required this.region_1depth_name,
    required this.region_2depth_name,
    required this.region_3depth_name,
    required this.road_name,
    required this.underground_yn,
    required this.main_building_no,
    required this.sub_building_no,
    required this.building_name,
    required this.zone_no,
  });

  factory DocumentRoadAddress.fromJson(Map<String, dynamic> json) => _$DocumentRoadAddressFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentRoadAddressToJson(this);

}
