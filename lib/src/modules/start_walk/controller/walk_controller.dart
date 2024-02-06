import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:walking_calculator/src/core/services/geolocator/geolocator_service.dart';
import 'package:walking_calculator/src/core/widget/map_widget/map_controller.dart';

import '../../../core/model/position_model.dart';
import '../../../core/model/walking_model.dart';
import '../../../core/services/walk_service/walk_service.dart';
import '../state/walk_state.dart';

class WalkController extends ValueNotifier<WalkState> {
  final IGeolocatorService geoLocatorService;
  final MapController mapController;
  final IWalkService walkService;

  WalkController(
    this.geoLocatorService,
    this.mapController,
    this.walkService,
  ) : super(WalkState());

  late Timer timer;

  void startWalking() async {
    final newValue = value.copyWith(walkButtonState: ButtonState.play);
    value = newValue;
    mapController.startDrawerPolilynes();

    await _fetchPosition();

    _takePositionPeriodically();
  }

  void pauseWalkinkg() {
    value = value.copyWith(
      walkButtonState: ButtonState.pause,
    );
    mapController.pauseDrawerPolilynes();
    timer.cancel();
  }

  void stopWalkinkg() async {
    if (value.positions.isNotEmpty) {
      _saveWalking();
    }

    value = value.copyWith(
      walkButtonState: ButtonState.stop,
      positions: [],
      walkDistance: 0,
      targetPercentageAchieved: 0,
    );

    mapController.stopDrawerPolilynes();
    timer.cancel();
  }

  Future<void> _saveWalking() async {
    await walkService.createNewWalk(
      WalkingModel(
        endTimeWalk: value.positions.last.date,
        positions: value.positions,
        startTimeWalk: value.positions.first.date,
        walkingDistance: value.walkDistance,
        walkingGoal: value.walkingGoal,
      ),
    );
  }

  void _takePositionPeriodically() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await _fetchPosition();

        if (value.positions.length >= 5) {
          final distance = geoLocatorService.calculateDistance(
            beginPosition: value.positions[value.positions.length - 2],
            endPosition: value.positions.last,
          );
          final walkingDistance = value.walkDistance + distance;
          final newValue = value.copyWith(
            walkDistance: walkingDistance,
            targetPercentageAchieved:
                ((walkingDistance * 100) / value.walkingGoal) / 100,
          );

          value = newValue;
        }
      },
    );
  }

  Future<void> _fetchPosition() async {
    final position = await geoLocatorService.getActualLocation();
    final List<PositionModel> newPositions = [...value.positions, position];
    final newValue = value.copyWith(positions: newPositions);
    value = newValue;
  }
}
