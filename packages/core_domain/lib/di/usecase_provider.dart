import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../map/map_coordinates_evenly_spaced_usecase.dart';

final mapCoordinatesEvenlySpacedUseCaseProvider =
    Provider<MapCoordinatesEvenlySpacedUseCase>((ref) {
  return MapCoordinatesEvenlySpacedUseCase();
});
