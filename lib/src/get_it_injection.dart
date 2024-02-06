import 'package:get_it/get_it.dart';
import 'package:walking_calculator/src/core/widget/map_widget/map_controller.dart';

import 'core/services/geolocator/geolocator_service.dart';
import 'core/services/local_storage/i_local_storage.dart';
import 'core/services/local_storage/shared_preferences_service.dart';
import 'core/services/walk_service/walk_service.dart';
import 'modules/start_walk/controller/walk_controller.dart';

final getIt = GetIt.instance;

void setUp() {
  getIt.registerSingleton<IGeolocatorService>(GeoLocatorService());

  getIt.registerFactory<IlocalStorage>(
    () => SharedPreferencesService(),
  );

  getIt.registerSingleton<MapController>(
    MapController(
      getIt.get<IGeolocatorService>(),
    ),
  );

  getIt.registerSingleton<IWalkService>(
    WalkService(
      getIt.get<IlocalStorage>(),
    ),
  );

  getIt.registerSingleton<WalkController>(
    WalkController(
      getIt.get<IGeolocatorService>(),
      getIt.get<MapController>(),
      getIt.get<IWalkService>(),
    ),
  );
  
}
