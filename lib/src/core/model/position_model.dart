class PositionModel {
  final double latitude;
  final double longitude;
  final DateTime date;

  const PositionModel({
    required this.latitude,
    required this.longitude,
    required this.date,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PositionModel &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.date == date;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode ^ date.hashCode;
}
