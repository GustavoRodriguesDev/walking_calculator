import 'package:walking_calculator/src/core/services/local_storage/i_local_storage.dart';

import '../../model/walking_model.dart';
import 'adapter/walk_adapter.dart';

abstract class IWalkService {
  Future<void> createNewWalk(WalkingModel walking);
  List<WalkingModel> readAllhiking();
}

class WalkService implements IWalkService {
  final IlocalStorage localStorage;

  WalkService(this.localStorage);
  @override
  Future<void> createNewWalk(WalkingModel walking) async {
    final hiking = localStorage.readStringList('walking');

    final walk = WalkAdapter.walkToMap(walking);

    hiking.add(walk);

    await localStorage.writeStringList('walking', hiking);
  }

  @override
  List<WalkingModel> readAllhiking() {
    final hiking = localStorage.readStringList('walking');

    return WalkAdapter.fromMap(hiking);
  }
}
