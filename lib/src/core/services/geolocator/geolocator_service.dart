import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:walking_calculator/src/core/model/position_model.dart';

abstract class IGeolocatorService {
  Future<void> checkPermissions();
  Future<PositionModel> getActualLocation();
  Stream<PositionModel> getActualLocationStream();
  double calculateDistance({
    required PositionModel beginPosition,
    required PositionModel endPosition,
  });
}

class GeoLocatorService implements IGeolocatorService {
  @override
  Future<void> checkPermissions() async {
    Geolocator.getServiceStatusStream();

    final permission = await Geolocator.checkPermission();
    if (LocationPermission.always != permission) {
      await Geolocator.requestPermission();
    }
  }

  @override
  Future<PositionModel> getActualLocation() async {
    final position = await Geolocator.getCurrentPosition();
    return PositionModel(
      latitude: position.latitude,
      longitude: position.longitude,
      date: position.timestamp.toLocal(),
    );
  }

  @override
  Stream<PositionModel> getActualLocationStream() {
    final position = Geolocator.getPositionStream();
    return position.map((event) => PositionModel(
          latitude: event.latitude,
          longitude: event.longitude,
          date: event.timestamp,
        ));
  }

  @override
  double calculateDistance({
    required PositionModel beginPosition,
    required PositionModel endPosition,
  }) {
    final distance = Geolocator.distanceBetween(
      beginPosition.latitude,
      beginPosition.longitude,
      endPosition.latitude,
      endPosition.longitude,
    );
    return double.parse((distance / 1000).toStringAsFixed(3));
  }
}
