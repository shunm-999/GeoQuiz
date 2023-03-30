import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:view_map/di/viewmodel_provider.dart';

class MapScreen extends HookConsumerWidget {
  final MapController _mapController = MapController();

  MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(mapViewModelProvider);
    final viewModel = ref.read(mapViewModelProvider.notifier);

    const double markerSize = 40;

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
            zoom: 3,
            maxZoom: 10,
            minZoom: 3,
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
              markers: uiState.worldHeritageList.map(
                (worldHeritage) {
                  final size = markerSize * (uiState.currentZoom / 3);

                  return Marker(
                    width: size * 2,
                    height: size * 2,
                    point:
                        LatLng(worldHeritage.latitude, worldHeritage.longitude),
                    builder: (ctx) => Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.place,
                            color: Colors.blue,
                            size: size,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
