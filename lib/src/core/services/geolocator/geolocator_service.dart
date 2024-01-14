import 'package:geolocator/geolocator.dart';
import 'package:walking_calculator/src/core/services/geolocator/position_model.dart';

abstract class IGeolocatorService {
  void checkPermissions();
  Future<PositionModel> getActualLocation();
  double calculateDistance({
    required PositionModel beginPosition,
    required PositionModel endPosition,
  });
}

class GeoLocatorService implements IGeolocatorService {
  @override
  void checkPermissions() async {
    final permission = await Geolocator.checkPermission();
    if (LocationPermission.always != permission) {
      Geolocator.requestPermission();
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
