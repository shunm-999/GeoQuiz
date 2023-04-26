import 'package:core_domain/di/usecase_provider.dart';
import 'package:core_domain/map/map_coordinates_evenly_spaced_usecase.dart';
import 'package:core_repository/di/repository_provider.dart';
import 'package:core_repository/geo_element_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

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
  final GeoElementRepository _geoElementRepository;
  final MapCoordinatesEvenlySpacedUseCase _mapCoordinatesEvenlySpacedUseCase;

  MapViewModel({
    required GeoElementRepository geoElementRepository,
    required MapCoordinatesEvenlySpacedUseCase
        mapCoordinatesEvenlySpacedUseCase,
  })  : _geoElementRepository = geoElementRepository,
        _mapCoordinatesEvenlySpacedUseCase = mapCoordinatesEvenlySpacedUseCase,
        super(
          MapUiState(
            initialPoint: LatLng(35.681, 139.767),
            currentZoom: 3,
            mapPinList: List<MapPin>.empty(),
          ),
        );

  void updateCurrentZoom(double currentZoom) {
    state = state.copyWith(currentZoom: currentZoom);
  }

  Future<void> fetchGeoElements({
    required double start,
    required double top,
    required double end,
    required double bottom,
  }) async {
    await _geoElementRepository
        .fetchGeoElements(
      start: start,
      top: top,
      end: end,
      bottom: bottom,
    )
        .then((result) {
      result.when(
        success: (geoElements) {
          final selectedGeoElements = _mapCoordinatesEvenlySpacedUseCase.invoke(
            count: 100,
            geoElements: geoElements,
            centerLatitude: (top + bottom) / 2,
            centerLongitude: (start + end) / 2,
          );

          final mapPinList = selectedGeoElements.map((element) {
            return MapPin(
              name: element.tags?.name ?? "",
              latitude: element.latitude ?? 0,
              longitude: element.longitude ?? 0,
            );
          }).toList();

          state = state.copyWith(mapPinList: mapPinList);
        },
        failure: (error) {},
      );
    });
  }
}
