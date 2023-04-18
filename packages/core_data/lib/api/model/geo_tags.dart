import 'package:json_annotation/json_annotation.dart';

part 'geo_tags.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoTagsResponseData {
  final String historic;
  final String? name;

  GeoTagsResponseData({
    required this.historic,
    required this.name,
  });

  factory GeoTagsResponseData.fromJson(Map<String, dynamic> json) =>
      _$GeoTagsFromJson(json);

  Map<String, dynamic> toJson() => _$GeoTagsToJson(this);
}
