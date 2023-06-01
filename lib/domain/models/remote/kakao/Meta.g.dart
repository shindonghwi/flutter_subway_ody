// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      is_end: json['is_end'] as bool,
      total_count: json['total_count'] as int,
      pageable_count: json['pageable_count'] as int,
      same_name: json['same_name'] == null
          ? null
          : MetaSameName.fromJson(json['same_name'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'is_end': instance.is_end,
      'total_count': instance.total_count,
      'pageable_count': instance.pageable_count,
      'same_name': instance.same_name,
    };
