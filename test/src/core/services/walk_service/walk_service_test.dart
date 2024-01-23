import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:walking_calculator/src/core/model/walking_model.dart';
import 'package:walking_calculator/src/core/services/local_storage/i_local_storage.dart';
import 'package:walking_calculator/src/core/services/walk_service/walk_service.dart';

class localStorageMock extends Mock implements IlocalStorage {}

void main() {
  late IlocalStorage localStorage;
  late IWalkService walkService;

  setUp(() {
    localStorage = localStorageMock();
    walkService = WalkService(localStorage);

    registerFallbackValue('');
    registerFallbackValue([]);
  });

  group('WalkService.createNewWalk', () {
    test('Should a new hike be added to the local list', () async {
      when(() => localStorage.readStringList(any())).thenReturn(<String>[]);
      when(() => localStorage.writeStringList(any(), any()))
          .thenAnswer((_) async => Future.value());

      walkService.createNewWalk(
        WalkingModel(
          endTimeWalk: DateTime.now(),
          positions: [],
          startTimeWalk: DateTime.now(),
          walkingDistance: 0,
          walkingGoal: 0,
        ),
      );

      verify(() => localStorage.readStringList(any())).called(1);
      verify(() => localStorage.writeStringList(any(), any())).called(1);
    });

    test('Should return a list of locally saved walks', () async {
      when(() => localStorage.readStringList(any())).thenReturn(<String>[]);

      final result = walkService.readAllhiking();

      expect(result, isA<List<WalkingModel>>());
      verify(() => localStorage.readStringList(any())).called(1);
    });
  });
}
