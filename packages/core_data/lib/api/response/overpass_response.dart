import 'package:core_data/api/model/geo_element.dart';
import 'package:json_annotation/json_annotation.dart';

part 'overpass_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OverpassResponse {
  final double version;
  final String generator;
  @JsonKey(name: "elements")
  final List<GeoElementResponseData> geoElements;

  OverpassResponse({
    required this.version,
    required this.generator,
    required this.geoElements,
  });

  factory OverpassResponse.fromJson(Map<String, dynamic> json) =>
      _$OverpassResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OverpassResponseToJson(this);
}
