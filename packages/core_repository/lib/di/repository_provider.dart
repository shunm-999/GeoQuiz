import 'package:core_data/api/di/api_provider.dart';
import 'package:core_repository/geo_element_repository.dart';
import 'package:core_repository/geo_element_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final geoElementRepositoryProvider = Provider<GeoElementRepository>((ref) {
  final overpassClient = ref.watch(overpassClientProvider);
  return GeoElementRepositoryImpl(client: overpassClient);
});
