import 'package:get_it/get_it.dart';
import 'package:walking_calculator/src/core/widget/map_widget/map_controller.dart';

import 'core/services/geolocator/geolocator_service.dart';
import 'modules/start_walk/walk_controller.dart';

final getIt = GetIt.instance;

void setUp() {
  getIt.registerSingleton<IGeolocatorService>(GeoLocatorService());
  getIt.registerSingleton<MapController>(
    MapController(
      getIt.get<IGeolocatorService>(),
    ),
  );
  getIt.registerSingleton<WalkController>(
    WalkController(
      getIt.get<IGeolocatorService>(),
      getIt.get<MapController>(),
    ),
  );
}