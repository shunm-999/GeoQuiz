import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:view_map/component/geo_element_detail_bottom_sheet.dart';

import '../viewmodel/map_viewmodel.dart';

class MapScreen extends StatefulHookConsumerWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();

    final uiState = ref.read(mapViewModelProvider);
    final currentPoint = uiState.initialPoint;
    final viewModel = ref.read(mapViewModelProvider.notifier);

    viewModel.fetchGeoElements(
      start: currentPoint.longitude - 3,
      top: currentPoint.latitude - 5,
      end: currentPoint.longitude + 3,
      bottom: currentPoint.latitude + 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final uiState = ref.watch(mapViewModelProvider);
    final viewModel = ref.read(mapViewModelProvider.notifier);

    const double markerSize = 25;
    const double initialZoom = 5;
    const double maxZoom = 20;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      body: Container(
        width: double.infinity,
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: uiState.initialPoint,
            zoom: initialZoom,
            maxZoom: maxZoom,
            minZoom: initialZoom,
            interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            onMapEvent: (MapEvent mapEvent) {
              if (mapEvent is MapEventMoveEnd) {
                viewModel.updateCurrentZoom(mapEvent.zoom);
              }
            },
          ),
          children: [
            TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
            MarkerLayer(
              markers: uiState.mapPinList.map(
                (mapPin) {
                  final size = markerSize * (uiState.currentZoom / initialZoom);

                  return Marker(
                    width: size * 2,
                    height: size * 2,
                    point: LatLng(
                      mapPin.latitude,
                      mapPin.longitude,
                    ),
                    builder: (ctx) => GestureDetector(
                      onTap: () {
                        showMapPinModelBottomSheet(
                          context: context,
                          geoElementName: mapPin.name,
                        );
                      },
                      child: Icon(
                        Icons.place,
                        color: Colors.blue,
                        size: size,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final currentPoint = _mapController.center;
          viewModel.fetchGeoElements(
            start: currentPoint.longitude - 3,
            top: currentPoint.latitude - 5,
            end: currentPoint.longitude + 3,
            bottom: currentPoint.latitude + 5,
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
