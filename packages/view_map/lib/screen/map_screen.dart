import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:view_map/di/viewmodel_provider.dart';

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
    final viewModel = ref.read(mapViewModelProvider.notifier);
    viewModel.fetchGeoElements();
  }

  @override
  Widget build(BuildContext context) {
    final uiState = ref.watch(mapViewModelProvider);
    final viewModel = ref.read(mapViewModelProvider.notifier);

    const double markerSize = 15;
    const double initialZoom = 3;
    const double maxZoom = 10;

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
                (worldHeritage) {
                  final size = markerSize * (uiState.currentZoom / initialZoom);

                  return Marker(
                    width: size * 2,
                    height: size * 2,
                    point:
                        LatLng(worldHeritage.latitude, worldHeritage.longitude),
                    builder: (ctx) => Icon(
                      Icons.place,
                      color: Colors.blue,
                      size: size,
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
