import 'package:core_data/api/model/geo_tags.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geo_element.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoElement {
  final String? type;
  @JsonKey(name: "id")
  final int elementId;
  @JsonKey(name: "lat")
  final double? latitude;
  @JsonKey(name: "lon")
  final double? longitude;
  final GeoTags? tags;

  GeoElement({
    required this.type,
    required this.elementId,
    required this.latitude,
    required this.longitude,
    required this.tags,
  });

  factory GeoElement.fromJson(Map<String, dynamic> json) =>
      _$GeoElementFromJson(json);

  Map<String, dynamic> toJson() => _$GeoElementToJson(this);
}
