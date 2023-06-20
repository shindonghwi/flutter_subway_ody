import 'package:json_annotation/json_annotation.dart';

import 'MetaSameName.dart';

part 'Meta.g.dart';

@JsonSerializable()
class Meta {
  bool? is_end;
  int? total_count;
  int? pageable_count;
  MetaSameName? same_name;

  Meta({
    required this.is_end,
    required this.total_count,
    required this.pageable_count,
    required this.same_name,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
