import 'package:flutter/foundation.dart';
import 'package:walking_calculator/src/core/model/position_model.dart';

class MapState {
  final List<PositionModel> positions;
  final PositionModel startPosition;
  final bool isDrawerPolilynes;

  MapState({
    List<PositionModel>? positions,
    required this.startPosition,
    this.isDrawerPolilynes = false,
  }) : positions = positions ?? [];

  factory MapState.init() {
    return MapState(
      startPosition: PositionModel(
        latitude: 0,
        longitude: 0,
        date: DateTime.now(),
      ),
    );
  }

  MapState copyWith({
    List<PositionModel>? positions,
    PositionModel? startPosition,
    bool? isDrawerPolilynes,
  }) {
    return MapState(
      positions: positions ?? this.positions,
      startPosition: startPosition ?? this.startPosition,
      isDrawerPolilynes: isDrawerPolilynes ?? this.isDrawerPolilynes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MapState &&
        listEquals(other.positions, positions) &&
        other.positions.length == positions.length &&
        other.startPosition == startPosition &&
        other.isDrawerPolilynes == isDrawerPolilynes;
  }

  @override
  int get hashCode =>
      positions.hashCode ^ startPosition.hashCode ^ isDrawerPolilynes.hashCode;
}
