import 'package:core_data/api/response/overpass_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'overpass_client.g.dart';

@RestApi(baseUrl: "https://overpass-api.de/api")
abstract class OverpassClient {
  factory OverpassClient(Dio dio, {String baseUrl}) = _OverpassClient;

  @GET("/interpreter")
  Future<OverpassResponse> fetchGeoElements({
    @Query("data") required String data,
  });
}
