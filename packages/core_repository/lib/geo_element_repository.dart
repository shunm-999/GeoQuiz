import 'package:core_model/geo_element.dart';
import 'package:core_model/result.dart';

abstract class GeoElementRepository {
  Future<Result<List<GeoElement>>> fetchGeoElements({
    int timeout,
    required double start,
    required double top,
    required double end,
    required double bottom,
  });
}
