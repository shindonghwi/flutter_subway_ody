import 'package:json_annotation/json_annotation.dart';

part 'Document.g.dart';

@JsonSerializable()
class Document {
  String? region_type;
  String? address_name;
  String? region_1depth_name;
  String? region_2depth_name;
  String? region_3depth_name;
  String? region_4depth_name;
  double? x;
  double? y;

  Document({
    required this.region_type,
    required this.address_name,
    required this.region_1depth_name,
    required this.region_2depth_name,
    required this.region_3depth_name,
    required this.region_4depth_name,
    required this.x,
    required this.y,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      region_type: json['region_type'],
      address_name: json['address_name'],
      region_1depth_name: json['region_1depth_name'],
      region_2depth_name: json['region_2depth_name'],
      region_3depth_name: json['region_3depth_name'],
      region_4depth_name: json['region_4depth_name'],
      x: json['x'],
      y: json['y'],
    );
  }

}