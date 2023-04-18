import 'geo_tags.dart';

class GeoElement {
  final String? type;
  final int elementId;
  final double? latitude;
  final double? longitude;
  final GeoTags? tags;

  GeoElement({
    required this.type,
    required this.elementId,
    required this.latitude,
    required this.longitude,
    required this.tags,
  });
}
