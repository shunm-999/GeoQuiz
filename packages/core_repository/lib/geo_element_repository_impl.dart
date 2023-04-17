import 'package:core_data/api/client/overpass_client.dart';
import 'package:core_data/api/model/geo_element.dart';
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
  Future<Result<List<GeoElement>>> fetchGeoElements({int timeout = 25}) {
    final data =
        '[out:json][timeout:$timeout];(node["historic"="memorial"](33.215712251730736,139.24072265625,36.35052700542763,143.876953125);way["historic"="memorial"](33.215712251730736,139.24072265625,36.35052700542763,143.876953125);relation["historic"="memorial"](33.215712251730736,139.24072265625,36.35052700542763,143.876953125););out body;>;out skel qt;';
    return _client.fetchGeoElements(data: data).then((response) {
      final geoElements = response.geoElements;
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
