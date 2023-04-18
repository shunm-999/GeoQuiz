// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_tags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoTagsResponseData _$GeoTagsFromJson(Map<String, dynamic> json) =>
    GeoTagsResponseData(
      historic: json['historic'] as String,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GeoTagsToJson(GeoTagsResponseData instance) =>
    <String, dynamic>{
      'historic': instance.historic,
      'name': instance.name,
    };
