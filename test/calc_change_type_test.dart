import 'package:animated_list_view/src/utils/calc_change_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('calcChangeType, equal', () {
    test('calcChangeType, equal, 1', () {
      final List<int> lstPrev = <int>[1];
      final List<int> lstNext = <int>[1];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.none);
    });

    test('calcChangeType, equal, 5', () {
      final List<int> lstPrev = <int>[1, 2, 3, 4, 5];
      final List<int> lstNext = <int>[1, 2, 3, 4, 5];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(2, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(3, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(4, lstPrev, lstNext), ChangeType.none);
    });
  });

  group('calcChangeType, insert at the beginning', () {
    test('calcChangeType, insert at the beginning, 1', () {
      final List<int> lstPrev = <int>[2];
      final List<int> lstNext = <int>[1, 2];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.add);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.none);
    });

    test('calcChangeType, insert at the beginning, 5', () {
      final List<int> lstPrev = <int>[2, 3, 4, 5];
      final List<int> lstNext = <int>[1, 2, 3, 4, 5];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.add);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(2, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(3, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(4, lstPrev, lstNext), ChangeType.none);
    });
  });

  group('calcChangeType, insert at the end', () {
    test('calcChangeType, insert at the end, 1', () {
      final List<int> lstPrev = <int>[1];
      final List<int> lstNext = <int>[1, 2];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.add);
    });

    test('calcChangeType, insert at the end, 5', () {
      final List<int> lstPrev = <int>[1, 2, 3, 4];
      final List<int> lstNext = <int>[1, 2, 3, 4, 5];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(2, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(3, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(4, lstPrev, lstNext), ChangeType.add);
    });
  });

  group('calcChangeType, remove from the beginning', () {
    test('calcChangeType, remove from the beginning, 1', () {
      final List<int> lstPrev = <int>[1, 2];
      final List<int> lstNext = <int>[2];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.remove);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.none);
    });

    test('calcChangeType, remove from the beginning, 5', () {
      final List<int> lstPrev = <int>[1, 2, 3, 4, 5];
      final List<int> lstNext = <int>[2, 3, 4, 5];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.remove);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(2, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(3, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(4, lstPrev, lstNext), ChangeType.none);
    });
  });

  group('calcChangeType, remove from the end', () {
    test('calcChangeType, remove from the end, 1', () {
      final List<int> lstPrev = <int>[1, 2];
      final List<int> lstNext = <int>[1];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.remove);
    });

    test('calcChangeType, remove from the beginning, 5', () {
      final List<int> lstPrev = <int>[1, 2, 3, 4, 5];
      final List<int> lstNext = <int>[1, 2, 3, 4];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(2, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(3, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(4, lstPrev, lstNext), ChangeType.remove);
    });
  });

  group('calcChangeType, insert at the middle', () {
    test('calcChangeType, insert at the middle, 1', () {
      final List<int> lstPrev = <int>[1, 3, 4, 5];
      final List<int> lstNext = <int>[1, 2, 3, 4, 5];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.add);
      expect(calcChangeType<int>(2, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(3, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(4, lstPrev, lstNext), ChangeType.none);
    });

    test('calcChangeType, insert at the middle, 2', () {
      final List<int> lstPrev = <int>[1, 2, 4, 5];
      final List<int> lstNext = <int>[1, 2, 3, 4, 5];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(2, lstPrev, lstNext), ChangeType.add);
      expect(calcChangeType<int>(3, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(4, lstPrev, lstNext), ChangeType.none);
    });

    test('calcChangeType, insert at the middle, 3', () {
      final List<int> lstPrev = <int>[1, 2, 3, 5];
      final List<int> lstNext = <int>[1, 2, 3, 4, 5];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(2, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(3, lstPrev, lstNext), ChangeType.add);
      expect(calcChangeType<int>(4, lstPrev, lstNext), ChangeType.none);
    });
  });

  group('calcChangeType, remove from the middle', () {
    test('calcChangeType, remove from the middle, 1', () {
      final List<int> lstPrev = <int>[1, 2, 3, 4, 5];
      final List<int> lstNext = <int>[1, 3, 4, 5];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.remove);
      expect(calcChangeType<int>(2, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(3, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(4, lstPrev, lstNext), ChangeType.none);
    });

    test('calcChangeType, remove from the middle, 2', () {
      final List<int> lstPrev = <int>[1, 2, 3, 4, 5];
      final List<int> lstNext = <int>[1, 2, 4, 5];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(2, lstPrev, lstNext), ChangeType.remove);
      expect(calcChangeType<int>(3, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(4, lstPrev, lstNext), ChangeType.none);
    });

    test('calcChangeType, remove from the middle, 3', () {
      final List<int> lstPrev = <int>[1, 2, 3, 4, 5];
      final List<int> lstNext = <int>[1, 2, 3, 5];

      expect(calcChangeType<int>(0, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(1, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(2, lstPrev, lstNext), ChangeType.none);
      expect(calcChangeType<int>(3, lstPrev, lstNext), ChangeType.remove);
      expect(calcChangeType<int>(4, lstPrev, lstNext), ChangeType.none);
    });
  });
}
