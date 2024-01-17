import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walking_calculator/src/core/services/geolocator/position_model.dart';
import 'package:walking_calculator/src/core/widget/map_widget/map_state.dart';

import '../../services/geolocator/geolocator_service.dart';

class MapController extends ValueNotifier<MapState> {
  final IGeolocatorService geolocatorService;
  MapController(this.geolocatorService) : super(MapState.init());

  late GoogleMapController? mapController;

  Future<void> setFirstPosition() async {
    final position = await geolocatorService.getActualLocation();
    value = value.copyWith(startPosition: position);
  }

  void fetchPositionForDrawerPolilynes() {
    final positions = geolocatorService.getActualLocationStream();

    positions.listen(
      (event) {
        if (value.isDrawerPolilynes) {
          final newState = value;
          final List<PositionModel> newListPosition = [
            ...value.positions,
            event
          ];
          value = newState.copyWith(positions: newListPosition);
        }
        if (mapController != null) {
          mapController!.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(
                event.latitude,
                event.longitude,
              ),
            ),
          );
        }
      },
    );
  }

  void startDrawerPolilynes() {
    final newState = value;
    final newValue = newState.copyWith(isDrawerPolilynes: true);
    value = newValue;
   
  }

  void stopDrawerPolilynes() {
    final newState = value;
    final newValue = newState.copyWith(isDrawerPolilynes: false);
    newValue.positions.clear();
    value = newValue;
  }

  void setMapsController(GoogleMapController controller) {
    mapController = controller;
  }
}
