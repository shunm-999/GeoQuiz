import 'dart:math';

import 'package:core_model/geo_element.dart';

class MapCoordinatesEvenlySpacedUseCase {
  List<GeoElement> invoke({
    required int count,
    required List<GeoElement> geoElements,
    required double centerLatitude,
    required double centerLongitude,
  }) {
    if (geoElements.length <= count) {
      return geoElements;
    }

    final List<_GeoElementWithDistance> geoWithDistanceList =
        geoElements.map((element) {
      final distance = _distanceSquare(
        centerLatitude,
        centerLongitude,
        element.latitude ?? 0,
        element.longitude ?? 0,
      );
      return _GeoElementWithDistance(
        geoElement: element,
        distanceSquare: distance,
      );
    }).toList();

    geoWithDistanceList
        .sort((a, b) => a.distanceSquare.compareTo(b.distanceSquare));

    final interval = geoWithDistanceList.length / count;
    final List<GeoElement> result = [];

    for (var i = 0; i < count; i++) {
      final index = (i * interval).toInt();
      result.add(geoWithDistanceList[index].geoElement);
    }

    return result;
  }

  double _distanceSquare(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    return (pow((lat1 - lat2), 2) + pow((lon1 - lon2), 2)).toDouble();
  }
}

class _GeoElementWithDistance {
  final GeoElement geoElement;
  final double distanceSquare;

  _GeoElementWithDistance({
    required this.geoElement,
    required this.distanceSquare,
  });
}
