import '../../../core/services/geolocator/position_model.dart';

class WalkState {
  final double walkingDistance;
  final double targetPercentageAchieved;
  final ButtonState walkButtonState;
  final List<PositionModel> positions;
  final double walkingGoal;

  WalkState({
    this.walkingDistance = 0,
    this.walkButtonState = ButtonState.stop,
    this.targetPercentageAchieved = 0,
    this.positions = const [],
    this.walkingGoal = 4,
  });

  WalkState copyWith({
    double? walkingDistance,
    double? targetPercentageAchieved,
    ButtonState? walkButtonState,
    List<PositionModel>? positions,
    double? walkingGoal,
  }) {
    return WalkState(
      walkingDistance: walkingDistance ?? this.walkingDistance,
      targetPercentageAchieved:
          targetPercentageAchieved ?? this.targetPercentageAchieved,
      walkButtonState: walkButtonState ?? this.walkButtonState,
      positions: positions ?? this.positions,
      walkingGoal: walkingGoal ?? this.walkingGoal,
    );
  }
}

enum ButtonState { stop, play }
