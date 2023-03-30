import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:view_map/viewmodel/map_viewmodel.dart';

final mapViewModelProvider =
    StateNotifierProvider.autoDispose<MapViewModel, MapUiState>((ref) {
  return MapViewModel();
});
