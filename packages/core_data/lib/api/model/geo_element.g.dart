// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoElement _$GeoElementFromJson(Map<String, dynamic> json) => GeoElement(
      type: json['type'] as String,
      elementId: json['id'] as String,
      latitude: json['lat'] as String?,
      longitude: json['lon'] as String?,
      tags: json['tags'] == null
          ? null
          : GeoTags.fromJson(json['tags'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeoElementToJson(GeoElement instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.elementId,
      'lat': instance.latitude,
      'lon': instance.longitude,
      'tags': instance.tags?.toJson(),
    };
