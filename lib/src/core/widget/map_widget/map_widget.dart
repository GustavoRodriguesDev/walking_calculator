import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walking_calculator/src/core/widget/map_widget/map_controller.dart';

import '../../../get_it_injection.dart';
import 'map_state.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = getIt<MapController>();
    mapController.fetchPositionForDrawerPolilynes();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MapState>(
      valueListenable: mapController,
      builder: (context, state, child) {
        return Expanded(
          child: GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            polylines: {
              Polyline(
                polylineId: const PolylineId("path_walking"),
                color: Colors.blue,
                points: state.positions
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              )
            },
            onMapCreated: mapController.setMapsController,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                state.startPosition.latitude,
                state.startPosition.longitude,
              ),
              zoom: 16,
            ),
          ),
        );
      },
    );
  }
}
