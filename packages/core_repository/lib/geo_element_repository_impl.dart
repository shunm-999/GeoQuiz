import 'package:core_data/api/client/overpass_client.dart';
import 'package:core_model/geo_element.dart';
import 'package:core_model/geo_tags.dart';
import 'package:core_model/result.dart';
import 'package:dio/dio.dart';

import 'geo_element_repository.dart';

class GeoElementRepositoryImpl with GeoElementRepository {
  final OverpassClient _client;

  GeoElementRepositoryImpl({
    required OverpassClient client,
  }) : _client = client;

  // TODO 範囲の指定（東西南北の緯度経度）
  @override
  Future<Result<List<GeoElement>>> fetchGeoElements({
    int timeout = 25,
    required double start,
    required double top,
    required double end,
    required double bottom,
  }) {
    // (33.215712251730736,139.24072265625,36.35052700542763,143.876953125)
    const type = '"historic"="memorial"';
    final area = "($top,$start,$bottom,$end)";
    final data =
        '[out:json][timeout:$timeout];(node[$type]$area;way[$type]$area;relation[$type]$area;);out body;>;out skel qt;';
    return _client.fetchGeoElements(data: data).then((response) {
      final geoElements = response.geoElements
          .map((e) => GeoElement(
                type: e.type,
                elementId: e.elementId,
                latitude: e.latitude,
                longitude: e.longitude,
                tags: GeoTags(
                  historic: e.tags?.historic ?? "",
                  name: e.tags?.name,
                ),
              ))
          .where((element) {
        return element.tags?.name != null;
      }).toList();
      return Result<List<GeoElement>>.success(
        geoElements,
      );
    }).catchError((error) {
      if (error is DioError) {
        return Result<List<GeoElement>>.failure(Exception(error.toString()));
      } else {
        return Result<List<GeoElement>>.failure(error);
      }
    });
  }
}
