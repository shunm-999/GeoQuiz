import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends HookConsumerWidget {
  final MapController _mapController = MapController();

  MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      body: Container(
        width: double.infinity,
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: LatLng(35.681, 139.767),
            zoom: 5,
            maxZoom: 10,
            minZoom: 3,
            onMapEvent: (MapEvent mapEvent) {},
          ),
          children: [
            TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
          ],
        ),
      ),
    );
  }
}
