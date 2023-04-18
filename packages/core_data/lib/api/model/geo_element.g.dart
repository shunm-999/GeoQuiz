// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoElementResponseData _$GeoElementFromJson(Map<String, dynamic> json) =>
    GeoElementResponseData(
      type: json['type'] as String?,
      elementId: json['id'] as int,
      latitude: (json['lat'] as num?)?.toDouble(),
      longitude: (json['lon'] as num?)?.toDouble(),
      tags: json['tags'] == null
          ? null
          : GeoTagsResponseData.fromJson(json['tags'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeoElementToJson(GeoElementResponseData instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.elementId,
      'lat': instance.latitude,
      'lon': instance.longitude,
      'tags': instance.tags?.toJson(),
    };
