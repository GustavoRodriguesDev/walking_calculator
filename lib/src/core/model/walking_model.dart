import 'position_model.dart';

class WalkingModel {
  final double walkingDistance;
  final List<PositionModel> positions;
  final double walkingGoal;
  final DateTime startTimeWalk;
  final DateTime endTimeWalk;

  WalkingModel({
    required this.walkingDistance,
    required this.positions,
    required this.walkingGoal,
    required this.startTimeWalk,
    required this.endTimeWalk,
  });
}
