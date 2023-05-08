import 'package:json_annotation/json_annotation.dart';

part 'geo_tags.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoTags {
  final String historic;
  final String? name;

  GeoTags({
    required this.historic,
    required this.name,
  });

  factory GeoTags.fromJson(Map<String, dynamic> json) =>
      _$GeoTagsFromJson(json);

  Map<String, dynamic> toJson() => _$GeoTagsToJson(this);
}
