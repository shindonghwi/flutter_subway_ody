
import 'package:json_annotation/json_annotation.dart';

part 'DocumentAddress.g.dart';

@JsonSerializable()
class DocumentAddress {
  String? address_name;
  String? region_1depth_name;
  String? region_2depth_name;
  String? region_3depth_name;
  String? mountain_yn;
  String? main_address_no;
  String? sub_address_no;
  String? zip_code;


  DocumentAddress({
    required this.address_name,
    required this.region_1depth_name,
    required this.region_2depth_name,
    required this.region_3depth_name,
    required this.mountain_yn,
    required this.main_address_no,
    required this.sub_address_no,
    required this.zip_code,
  });

  factory DocumentAddress.fromJson(Map<String, dynamic> json) => _$DocumentAddressFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentAddressToJson(this);

}
