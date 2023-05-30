import 'package:json_annotation/json_annotation.dart';

part 'Meta.g.dart';

@JsonSerializable()
class Meta {
  int totalCount;

  Meta({required this.totalCount});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      totalCount: json['total_count'],
    );
  }
}
