import 'package:core_repository/geo_element_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

@immutable
class MapUiState {
  final LatLng initialPoint;
  final double currentZoom;
  final List<MapPin> mapPinList;

  const MapUiState({
    required this.initialPoint,
    required this.currentZoom,
    required this.mapPinList,
  });

  MapUiState copyWith({
    LatLng? initialPoint,
    double? currentZoom,
    List<MapPin>? mapPinList,
  }) {
    return MapUiState(
      initialPoint: initialPoint ?? this.initialPoint,
      currentZoom: currentZoom ?? this.currentZoom,
      mapPinList: mapPinList ?? this.mapPinList,
    );
  }
}

class MapPin {
  final String name;
  final double latitude;
  final double longitude;

  MapPin({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

class MapViewModel extends StateNotifier<MapUiState> {
  final GeoElementRepository geoElementRepository;

  MapViewModel({
    required this.geoElementRepository,
  }) : super(
          MapUiState(
            initialPoint: LatLng(35.681, 139.767),
            currentZoom: 3,
            mapPinList: List<MapPin>.empty(),
          ),
        );

  void updateCurrentZoom(double currentZoom) {
    state = state.copyWith(currentZoom: currentZoom);
  }

  Future<void> fetchGeoElements() async {
    await geoElementRepository.fetchGeoElements().then((result) {
      result.when(
          success: (geoElements) {
            final mapPinList = geoElements.map((element) {
              return MapPin(
                name: element.tags?.name ?? "",
                latitude: element.latitude ?? 0,
                longitude: element.longitude ?? 0,
              );
            }).toList();

            state = state.copyWith(mapPinList: mapPinList.take(50).toList());
          },
          failure: (error) {});
    });
  }
}
