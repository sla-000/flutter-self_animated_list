import 'package:animated_list_view/animated_list_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test mergeChanges function', () {
    test('Test merge equal short', () {
      final x = [1];
      final y = [1];

      expect(mergeChanges(x, y), [1]);
    });

    test('Test merge equal long', () {
      final x = [1, 2, 3, 4];
      final y = [1, 2, 3, 4];

      expect(mergeChanges(x, y), [1, 2, 3, 4]);
    });

    test('Test merge add to start', () {
      final x = [2, 3, 4];
      final y = [5, 6, 7, 2, 3, 4];

      expect(mergeChanges(x, y), [5, 6, 7, 2, 3, 4]);
    });

    test('Test merge add to midle', () {
      final x = [1, 2, 3, 4];
      final y = [1, 2, 8, 9, 10, 3, 4];

      expect(mergeChanges(x, y), [1, 2, 8, 9, 10, 3, 4]);
    });

    test('Test merge add to end', () {
      final x = [1, 2, 3, 4];
      final y = [1, 2, 3, 4, 8, 9, 10];

      expect(mergeChanges(x, y), [1, 2, 3, 4, 8, 9, 10]);
    });

    test('Test merge remove from start', () {
      final x = [1, 2, 3, 4, 5];
      final y = [4, 5];

      expect(mergeChanges(x, y), [1, 2, 3, 4, 5]);
    });

    test('Test merge remove from middle', () {
      final x = [1, 2, 3, 4, 5, 6];
      final y = [1, 2, 6];

      expect(mergeChanges(x, y), [1, 2, 3, 4, 5, 6]);
    });

    test('Test merge remove from end', () {
      final x = [1, 2, 3, 4, 5, 6];
      final y = [1, 2];

      expect(mergeChanges(x, y), [1, 2, 3, 4, 5, 6]);
    });

    test('Test merge multiple adds and removes', () {
      final x = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
      final y = [17, 18, 3, 5, 7, 8, 10, 13, 14, 15, 11];

      expect(mergeChanges(x, y),
          [17, 18, 3, 4, 5, 6, 7, 8, 9, 10, 13, 14, 15, 11, 12]);
    });

    test('Test merge multiple adds and removes', () {
      final x = ["3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];
      final y = ["17", "18", "3", "5", "7", "8", "10", "13", "14", "15", "11"];

      expect(
          mergeChanges(x, y,
              isEqual: (x, y) => x.runtimeType == y.runtimeType && x == y),
          [
            "17", "18", "3", "4", "5", "6", "7", "8", "9", "10", "13", "14", //
            "15", "11", "12"
          ]);
    });

    test('Test merge duplicates', () {
      final x = [1, 2, 3, 5, 6];
      final y = [2, 3, 3, 6, 7, 8];

      expect(mergeChanges(x, y), [1, 2, 3, 5, 6, 7, 8]);
    });
  });

  group('Test copyOnlyUnique function', () {
    test('Test copyOnlyUnique', () {
      final x = [1, 2, 3, 4, 4, 5, 6, 5, 1, 2, 1, 1, 3, 7];

      expect(
        copyOnlyUnique(x),
        [1, 2, 3, 4, 5, 6, 7],
      );
    });
  });
}
