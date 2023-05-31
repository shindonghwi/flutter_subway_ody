import 'package:json_annotation/json_annotation.dart';

part 'Meta.g.dart';

@JsonSerializable()
class Meta {
  int total_count;

  Meta({required this.total_count});


  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
