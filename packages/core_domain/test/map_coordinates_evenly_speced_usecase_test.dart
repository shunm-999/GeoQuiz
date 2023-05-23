import 'package:core_domain/map/map_coordinates_evenly_spaced_usecase.dart';
import 'package:core_model/geo_element.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MapCoordinatesEvenlySpacedUseCase', () {
    final useCase = MapCoordinatesEvenlySpacedUseCase();

    test('should extract the specified number of elements from geoElements',
        () {
      // Prepare test data
      final geoElements = _generateGeoElements(5);
      const count = 3;
      const centerLatitude = 0.0;
      const centerLongitude = 0.0;

      // Invoke the use case
      final result = useCase.invoke(
        count: count,
        geoElements: geoElements,
        centerLatitude: centerLatitude,
        centerLongitude: centerLongitude,
      );

      // Perform assertions
      expect(result.length, equals(count));
    });

    test(
        'should return all geoElements if count is greater than or equal to the length of geoElements',
        () {
      // Prepare test data
      final geoElements = _generateGeoElements(5);
      const count = 10; // Greater than the length of geoElements
      const centerLatitude = 0.0;
      const centerLongitude = 0.0;

      // Invoke the use case
      final result = useCase.invoke(
        count: count,
        geoElements: geoElements,
        centerLatitude: centerLatitude,
        centerLongitude: centerLongitude,
      );

      // Perform assertions
      expect(result.length, equals(geoElements.length));
      expect(result, equals(geoElements));
    });
  });
}

List<GeoElement> _generateGeoElements(int count, {bool isShuffled = false}) {
  final List<GeoElement> geoElements = [];
  for (int i = 0; i < count; i++) {
    geoElements.add(GeoElement(
      type: 'type',
      elementId: i,
      latitude: i.toDouble(),
      longitude: i.toDouble(),
      tags: null,
    ));
  }
  if (isShuffled) {
    return geoElements..shuffle();
  } else {
    return geoElements;
  }
}
