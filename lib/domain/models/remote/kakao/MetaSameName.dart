import 'package:json_annotation/json_annotation.dart';

part 'MetaSameName.g.dart';

@JsonSerializable()
class MetaSameName {
  String? keyword;
  String? selected_region;
  List<String>? region;

  MetaSameName({
    required this.keyword,
    required this.selected_region,
    required this.region,
  });

  factory MetaSameName.fromJson(Map<String, dynamic> json) =>
      _$MetaSameNameFromJson(json);

  Map<String, dynamic> toJson() => _$MetaSameNameToJson(this);
}
