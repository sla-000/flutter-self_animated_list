import 'package:flutter_test/flutter_test.dart';

import 'package:animated_list_view/animated_list_view.dart';

void main() {
  group('Test merge function', () {
    test('Test merge equal short', () {
      final x = [1];
      final y = [1];

      expect(mergeOneChange(x, y), [1]);
    });

    test('Test merge equal long', () {
      final x = [1, 2, 3, 4];
      final y = [1, 2, 3, 4];

      expect(mergeOneChange(x, y), [1, 2, 3, 4]);
    });

    test('Test merge add to start', () {
      final x = [2, 3, 4];
      final y = [1, 2, 3, 4];

      expect(mergeOneChange(x, y), [1, 2, 3, 4]);
    });

    test('Test merge add to midle', () {
      final x = [1, 2, 3, 4];
      final y = [1, 2, 8, 3, 4];

      expect(mergeOneChange(x, y), [1, 2, 8, 3, 4]);
    });

    test('Test merge add to end', () {
      final x = [1, 2, 3, 4];
      final y = [1, 2, 3, 4, 8];

      expect(mergeOneChange(x, y), [1, 2, 3, 4, 8]);
    });

    test('Test merge remove from start', () {
      final x = [1, 2, 3, 4];
      final y = [2, 3, 4];

      expect(mergeOneChange(x, y), [1, 2, 3, 4]);
    });

    test('Test merge remove from middle', () {
      final x = [1, 2, 3, 4];
      final y = [1, 2, 4];

      expect(mergeOneChange(x, y), [1, 2, 3, 4]);
    });

    test('Test merge remove from end', () {
      final x = [1, 2, 3, 4];
      final y = [1, 2, 3];

      expect(mergeOneChange(x, y), [1, 2, 3, 4]);
    });
  });
}
