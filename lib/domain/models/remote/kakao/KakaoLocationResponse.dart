import 'package:json_annotation/json_annotation.dart';
import 'Document.dart';
import 'Meta.dart';

part 'KakaoLocationResponse.g.dart';

@JsonSerializable()
class KakaoLocationResponse {
  Meta? meta;
  List<Document>? documents;

  KakaoLocationResponse({required this.meta, required this.documents});

  factory KakaoLocationResponse.fromJson(Map<String, dynamic> json) => _$KakaoLocationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KakaoLocationResponseToJson(this);
}

