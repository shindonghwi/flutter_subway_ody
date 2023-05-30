// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'KakaoLocationResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KakaoLocationResponse _$KakaoLocationResponseFromJson(
        Map<String, dynamic> json) =>
    KakaoLocationResponse(
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KakaoLocationResponseToJson(
        KakaoLocationResponse instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'documents': instance.documents,
    };
