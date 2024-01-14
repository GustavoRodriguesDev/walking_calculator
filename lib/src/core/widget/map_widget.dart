import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walking_calculator/src/core/services/geolocator/position_model.dart';

class MapWidget extends StatefulWidget {
  final List<PositionModel> positions;

  const MapWidget({
    Key? key,
    required this.positions,
  }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        onCameraMove: (position) {},
        polylines: {
          Polyline(
            polylineId: const PolylineId("path_walking"),
            color: Colors.blue,
            points: widget.positions
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          )
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
              widget.positions.last.latitude, widget.positions.last.longitude),
          zoom: 16,
        ),
      ),
    );
  }

  LatLng currentPosition() {
    if (widget.positions.isEmpty) return const LatLng(0, 0);
    return LatLng(
      widget.positions.last.latitude,
      widget.positions.last.longitude,
    );
  }
}
