import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:walking_calculator/src/core/services/geolocator/geolocator_service.dart';

import '../../core/services/geolocator/position_model.dart';
import 'state/walk_state.dart';

class WalkController extends ValueNotifier<WalkState> {
  final GeoLocatorService geoLocatorService = GeoLocatorService();
  WalkController() : super(WalkState());

  late Timer time;

  void startWalk() async {
    value = value.copyWith(walkButtonState: ButtonState.play);

    await _fetchPosition();
    time = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await _fetchPosition();

      if (value.positions.length >= 2) {
        final distance = geoLocatorService.calculateDistance(
          beginPosition: value.positions[value.positions.length - 2],
          endPosition: value.positions.last,
        );
        final walkingDistance = value.walkingDistance + distance;
        final newValue = value.copyWith(
            walkingDistance: walkingDistance,
            targetPercentageAchieved:
                ((walkingDistance * 100) / value.walkingGoal) / 100);

        value = newValue;
      }
    });
  }

  Future<void> _fetchPosition() async {
    final position = await geoLocatorService.getActualLocation();
    final List<PositionModel> newPositions = [...value.positions, position];
    final newValue = value.copyWith(positions: newPositions);
    value = newValue;
  }

  void stop() {
    value = value.copyWith(walkButtonState: ButtonState.stop);
    time.cancel();
  }
}
