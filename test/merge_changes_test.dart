import 'package:animated_list_view/src/utils/merge.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test mergeChanges function', () {
    test('Test merge equal short', () {
      final List<int> x = <int>[1];
      final List<int> y = <int>[1];

      expect(mergeChanges(x, y), <int>[1]);
    });

    test('Test merge equal long', () {
      final List<int> x = <int>[1, 2, 3, 4];
      final List<int> y = <int>[1, 2, 3, 4];

      expect(mergeChanges(x, y), <int>[1, 2, 3, 4]);
    });

    test('Test merge add to start', () {
      final List<int> x = <int>[2, 3, 4];
      final List<int> y = <int>[5, 6, 7, 2, 3, 4];

      expect(mergeChanges(x, y), <int>[5, 6, 7, 2, 3, 4]);
    });

    test('Test merge add to middle', () {
      final List<int> x = <int>[1, 2, 3, 4];
      final List<int> y = <int>[1, 2, 8, 9, 10, 3, 4];

      expect(mergeChanges(x, y), <int>[1, 2, 8, 9, 10, 3, 4]);
    });

    test('Test merge add to end', () {
      final List<int> x = <int>[1, 2, 3, 4];
      final List<int> y = <int>[1, 2, 3, 4, 8, 9, 10];

      expect(mergeChanges(x, y), <int>[1, 2, 3, 4, 8, 9, 10]);
    });

    test('Test merge remove from start', () {
      final List<int> x = <int>[1, 2, 3, 4, 5];
      final List<int> y = <int>[4, 5];

      expect(mergeChanges(x, y), <int>[1, 2, 3, 4, 5]);
    });

    test('Test merge remove from middle', () {
      final List<int> x = <int>[1, 2, 3, 4, 5, 6];
      final List<int> y = <int>[1, 2, 6];

      expect(mergeChanges(x, y), <int>[1, 2, 3, 4, 5, 6]);
    });

    test('Test merge remove from end', () {
      final List<int> x = <int>[1, 2, 3, 4, 5, 6];
      final List<int> y = <int>[1, 2];

      expect(mergeChanges(x, y), <int>[1, 2, 3, 4, 5, 6]);
    });

    test('Test merge multiple adds and removes', () {
      final List<int> x = <int>[3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
      final List<int> y = <int>[17, 18, 3, 5, 7, 8, 10, 13, 14, 15, 11];

      expect(mergeChanges(x, y),
          <int>[17, 18, 3, 4, 5, 6, 7, 8, 9, 10, 13, 14, 15, 11, 12]);
    });

    test('Test merge multiple adds and removes', () {
      final List<String> x = <String>[
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12'
      ];
      final List<String> y = <String>[
        '17',
        '18',
        '3',
        '5',
        '7',
        '8',
        '10',
        '13',
        '14',
        '15',
        '11'
      ];

      expect(
          mergeChanges(x, y,
              isEqual: (String x, String y) =>
                  x.runtimeType == y.runtimeType && x == y),
          <String>[
            '17', '18', '3', '4', '5', '6', '7', '8', '9', '10', '13', '14', //
            '15', '11', '12'
          ]);
    });

    test('Test merge duplicates in 1', () {
      final List<int> x = <int>[1, 2, 3, 5, 5, 5, 6];
      final List<int> y = <int>[2, 3, 6, 7, 8];

      expect(mergeChanges(x, y), <int>[1, 2, 3, 5, 6, 7, 8]);
    });

    test('Test merge duplicates in 2', () {
      final List<int> x = <int>[1, 2, 3, 5, 6];
      final List<int> y = <int>[2, 3, 3, 3, 3, 6, 7, 8];

      expect(mergeChanges(x, y), <int>[1, 2, 3, 5, 6, 7, 8]);
    });

    test('Test merge duplicates in both', () {
      final List<int> x = <int>[1, 1, 1, 2, 3, 5, 5, 5, 6];
      final List<int> y = <int>[2, 2, 3, 3, 3, 3, 6, 7, 8, 8, 8, 4, 4];

      expect(mergeChanges(x, y), <int>[1, 2, 3, 5, 6, 7, 8, 4]);
    });

    test('Test merge append', () {
      final List<int> x = <int>[1, 2, 3, 5, 6, 4];
      final List<int> y = <int>[2, 3, 6, 7, 8];

      expect(mergeChanges(x, y), <int>[1, 2, 3, 5, 6, 4, 7, 8]);
    });

    test('Test merge append 2', () {
      final List<int> x = <int>[2, 3, 6, 7, 8, 9, 10];
      final List<int> y = <int>[1, 2, 3, 5, 6, 4, 11, 12];

      expect(mergeChanges(x, y), <int>[1, 2, 3, 5, 6, 7, 4, 8, 11, 9, 12, 10]);
    });

    test('Test merge append 3', () {
      final List<int> x = <int>[1, 2, 3, 5, 6, 4, 11, 12];
      final List<int> y = <int>[2, 3, 6, 7, 8, 9, 10];

      expect(mergeChanges(x, y), <int>[1, 2, 3, 5, 6, 4, 7, 11, 8, 12, 9, 10]);
    });
  });
}
