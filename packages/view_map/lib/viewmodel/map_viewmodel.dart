import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

@immutable
class MapUiState {
  final LatLng initialPoint;
  final double currentZoom;
  final List<WorldHeritage> worldHeritageList;

  const MapUiState({
    required this.initialPoint,
    required this.currentZoom,
    required this.worldHeritageList,
  });

  MapUiState copyWith({
    LatLng? initialPoint,
    double? currentZoom,
    List<WorldHeritage>? worldHeritageList,
  }) {
    return MapUiState(
      initialPoint: initialPoint ?? this.initialPoint,
      currentZoom: currentZoom ?? this.currentZoom,
      worldHeritageList: worldHeritageList ?? this.worldHeritageList,
    );
  }
}

class WorldHeritage {
  final double latitude;
  final double longitude;
  final String name;

  const WorldHeritage(
      {required this.latitude, required this.longitude, required this.name});
}

const WorldHeritage _japan =
    WorldHeritage(latitude: 35.681, longitude: 139.767, name: "japan");
const WorldHeritage _london =
    WorldHeritage(latitude: 51.5, longitude: -0.09, name: "london");
const WorldHeritage _paris =
    WorldHeritage(latitude: 48.8566, longitude: 2.3522, name: "paris");
const WorldHeritage _dublin =
    WorldHeritage(latitude: 53.3498, longitude: -6.2603, name: "doblin");

const List<WorldHeritage> _worldHeritageList = [
  _japan,
  _london,
  _paris,
  _dublin
];

class MapViewModel extends StateNotifier<MapUiState> {
  MapViewModel()
      : super(
          MapUiState(
            initialPoint: LatLng(35.681, 139.767),
            currentZoom: 3,
            worldHeritageList: List.unmodifiable(
              _worldHeritageList,
            ),
          ),
        );

  void updateCurrentZoom(double currentZoom) {
    state = state.copyWith(currentZoom: currentZoom);
  }
}
