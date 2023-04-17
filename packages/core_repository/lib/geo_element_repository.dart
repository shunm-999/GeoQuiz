import 'package:core_data/api/model/geo_element.dart';
import 'package:core_model/result.dart';

abstract class GeoElementRepository {
  Future<Result<List<GeoElement>>> fetchGeoElements();
}
