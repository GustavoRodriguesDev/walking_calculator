import 'dart:convert';

import 'package:walking_calculator/src/core/model/walking_model.dart';

import '../../../model/position_model.dart';

class WalkAdapter {
  static String walkToMap(WalkingModel walking) {
    return '''{
      "positions": ${walking.positions.map(_positionToMap).toList()},
      "walking_goal": ${walking.walkingGoal},
      "start_time_walk": ${walking.startTimeWalk.toIso8601String()},
      "end_time_walk": ${walking.endTimeWalk.toIso8601String()},
      "walking_distance": ${walking.walkingDistance},
    }''';
  }

  static List<WalkingModel> fromMap(List<String> walkings) {
    return walkings.map(
      (value) {
        final walking = jsonDecode(value);
        return WalkingModel(
          endTimeWalk: walking[''],
          positions: List.castFrom(walking['positions'])
              .map((e) => _positionFromMap(e))
              .toList(),
          startTimeWalk: walking[''],
          walkingDistance: walking[''],
          walkingGoal: walking[''],
        );
      },
    ).toList();
  }

  static Map<String, dynamic> _positionToMap(PositionModel position) {
    return {
      "latitude": position.latitude,
      "longitude": position.longitude,
      "date_time_position": position.date.toIso8601String(),
    };
  }

  static PositionModel _positionFromMap(Map position) {
    return PositionModel(
      date: position['date_time_position'],
      latitude: position['latitude'],
      longitude: position['longitude'],
    );
  }
}
