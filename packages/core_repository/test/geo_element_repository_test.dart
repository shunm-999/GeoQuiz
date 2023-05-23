import 'package:core_data/api/client/overpass_client.dart';
import 'package:core_data/api/model/geo_element.dart';
import 'package:core_data/api/response/overpass_response.dart';
import 'package:core_model/result.dart';
import 'package:core_repository/geo_element_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockOverpassClient extends Mock implements OverpassClient {}

void main() {
  group('GeoElementRepositoryImpl', () {
    final mockClient = MockOverpassClient();
    final repository = GeoElementRepositoryImpl(client: mockClient);

    test('should fetch geo elements successfully', () async {
      // Prepare test data
      const timeout = 25;
      const start = 139.24072265625;
      const top = 33.215712251730736;
      const end = 143.876953125;
      const bottom = 36.35052700542763;
      final mockResponse = OverpassResponse(
        version: 1.0,
        generator: 'MockGenerator',
        geoElements: [
          GeoElement(
            type: 'node',
            elementId: 1,
            latitude: 33.215712251730736,
            longitude: 139.24072265625,
            tags: null,
          ),
          // Add more sample GeoElements as needed
        ],
      );

      // Mock the client's fetchGeoElements method
      when(mockClient.fetchGeoElements(data: anyNamed('data') ?? ""))
          .thenAnswer((_) async => mockResponse);

      // Invoke the repository method
      final result = await repository.fetchGeoElements(
        timeout: timeout,
        start: start,
        top: top,
        end: end,
        bottom: bottom,
      );

      // Perform assertions
      expect(result, isA<Result<List<GeoElement>>>());
      expect(result is Success, isTrue);
      expect(
        result.whenOrNull(
          success: (value) => value,
        ),
        isA<List<GeoElement>>(),
      );
      expect(
        result.whenOrNull(
          success: (value) => value,
        ),
        isNotEmpty,
      );
      // Add more assertions based on your expected response data
    });

    test('should return an error result on client failure', () async {
      // Prepare test data
      const timeout = 25;
      const start = 139.24072265625;
      const top = 33.215712251730736;
      const end = 143.876953125;
      const bottom = 36.35052700542763;
      const errorMessage = 'Network error';

      // Mock the client's fetchGeoElements method to throw an error
      when(mockClient.fetchGeoElements(data: anyNamed('data') ?? ""))
          .thenThrow(Exception(errorMessage));

      // Invoke the repository method
      final result = await repository.fetchGeoElements(
        timeout: timeout,
        start: start,
        top: top,
        end: end,
        bottom: bottom,
      );

      // Perform assertions
      expect(result, isA<Result<List<GeoElement>>>());
      expect(result is Failure, isTrue);
      expect(
        result.when(
          success: (value) => null,
          failure: (error) => error,
        ),
        isException,
      );
      expect(
        result.when(
          success: (value) => null,
          failure: (error) => error.toString(),
        ),
        equals(errorMessage),
      );
    });
  });
}
