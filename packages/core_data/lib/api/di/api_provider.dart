import 'package:core_data/api/client/overpass_client.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _dioProvider = Provider<Dio>((ref) => Dio());

final overpassClientProvider = Provider<OverpassClient>((ref){
  final dioProvider = ref.watch(_dioProvider);
  return OverpassClient(dioProvider);
});
