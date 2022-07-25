import 'package:animated_list_view/src/utils/search_changes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('searchChanges', () {
    group('searchChanges, add', () {
      test('searchChanges, add many', () {
        final List<int> initial = <int>[];
        const List<int> target = <int>[1, 2, 3, 4, 5];

        searchChanges<int>(
          initial: initial,
          target: target,
        );

        expect(initial, target);
      });
    });

    group('searchChanges, remove', () {
      test('searchChanges, remove all', () {
        final List<int> initial = <int>[1, 2, 3, 4, 5];
        const List<int> target = <int>[];

        searchChanges<int>(
          initial: initial,
          target: target,
        );

        expect(initial, target);
      });
    });

    group('searchChanges, swap', () {
      test('searchChanges, swap simple', () {
        final List<int> initial = <int>[1, 2, 3, 4, 5];
        const List<int> target = <int>[1, 4, 3, 4, 2];

        searchChanges<int>(
          initial: initial,
          target: target,
        );

        expect(initial, target);
      });

      test('searchChanges, swap all', () {
        final List<int> initial = <int>[1, 2, 3, 4, 5];
        const List<int> target = <int>[3, 4, 1, 4, 2];

        searchChanges<int>(
          initial: initial,
          target: target,
        );

        expect(initial, target);
      });

      test('searchChanges, swap duplicates', () {
        final List<int> initial = <int>[1, 2, 3, 2, 4, 5];
        const List<int> target = <int>[5, 3, 2, 2, 4, 1];

        searchChanges<int>(
          initial: initial,
          target: target,
        );

        expect(initial, target);
      });
    });

    group('searchChanges, all', () {
      test('searchChanges, 1', () {
        final List<int> initial = <int>[1, 1, 1, 1, 1, 2];
        const List<int> target = <int>[1, 2, 1, 1, 1, 1, 2, 1];

        searchChanges<int>(initial: initial, target: target);
        expect(initial, target);
      });

      test('searchChanges, 2', () {
        final List<int> initial = <int>[2, 1, 1, 1, 2, 1, 1, 2];
        const List<int> target = <int>[1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1];

        searchChanges<int>(initial: initial, target: target);
        expect(initial, target);
      });

      test('searchChanges, 3', () {
        final List<int> initial = <int>[1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1];
        const List<int> target = <int>[2, 1, 1, 1, 2, 1, 1, 2];

        searchChanges<int>(initial: initial, target: target);
        expect(initial, target);
      });
    });
  });
}
