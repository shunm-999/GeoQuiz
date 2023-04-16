// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overpass_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverpassResponse _$OverpassResponseFromJson(Map<String, dynamic> json) =>
    OverpassResponse(
      version: json['version'] as String,
      generator: json['generator'] as String,
      geoElements: (json['geoElements'] as List<dynamic>)
          .map((e) => GeoElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OverpassResponseToJson(OverpassResponse instance) =>
    <String, dynamic>{
      'version': instance.version,
      'generator': instance.generator,
      'geoElements': instance.geoElements.map((e) => e.toJson()).toList(),
    };
