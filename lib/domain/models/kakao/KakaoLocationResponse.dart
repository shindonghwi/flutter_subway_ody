import 'package:json_annotation/json_annotation.dart';
import 'package:subway_ody/domain/models/kakao/Document.dart';
import 'package:subway_ody/domain/models/kakao/Meta.dart';

part 'KakaoLocationResponse.g.dart';

@JsonSerializable()
class KakaoLocationResponse {
  Meta? meta;
  List<Document>? documents;

  KakaoLocationResponse({required this.meta, required this.documents});

  factory KakaoLocationResponse.fromJson(Map<String, dynamic> json) {
    return KakaoLocationResponse(
      meta: Meta.fromJson(json['meta']),
      documents: List<Document>.from(json['documents'].map((x) => Document.fromJson(x))),
    );
  }
}

