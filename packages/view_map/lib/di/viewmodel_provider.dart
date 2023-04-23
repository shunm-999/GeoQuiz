import 'package:core_domain/di/usecase_provider.dart';
import 'package:core_repository/di/repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:view_map/viewmodel/map_viewmodel.dart';

final mapViewModelProvider =
    StateNotifierProvider.autoDispose<MapViewModel, MapUiState>((ref) {
  final geoElementRepository = ref.watch(geoElementRepositoryProvider);
  final mapCoordinatesEvenlySpacedUseCase =
      ref.watch(mapCoordinatesEvenlySpacedUseCaseProvider);
  return MapViewModel(
    geoElementRepository: geoElementRepository,
    mapCoordinatesEvenlySpacedUseCase: mapCoordinatesEvenlySpacedUseCase,
  );
});
