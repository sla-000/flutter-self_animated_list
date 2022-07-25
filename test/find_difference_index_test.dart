import 'package:animated_list_view/src/utils/search_changes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('findDifferenceIndex', () {
    group('findDifferenceIndex, remove', () {
      test('findDifferenceIndex, remove at start', () {
        final List<int> initial = <int>[1, 2];
        const List<int> target = <int>[2];

        expect(findDifferenceIndex<int>(initial: initial, target: target), 0);
      });

      test('findDifferenceIndex, remove at middle', () {
        final List<int> initial = <int>[1, 2, 3];
        const List<int> target = <int>[1, 3];

        expect(findDifferenceIndex<int>(initial: initial, target: target), 1);
      });

      test('findDifferenceIndex, remove at end', () {
        final List<int> initial = <int>[1, 2, 3];
        const List<int> target = <int>[1, 2];

        expect(findDifferenceIndex<int>(initial: initial, target: target), 2);
      });
    });

    group('findDifferenceIndex, add', () {
      test('findDifferenceIndex, add at start', () {
        final List<int> initial = <int>[2, 3];
        const List<int> target = <int>[1, 2, 3];

        expect(findDifferenceIndex<int>(initial: initial, target: target), 0);
      });

      test('findDifferenceIndex, add at middle', () {
        final List<int> initial = <int>[1, 3];
        const List<int> target = <int>[1, 2, 3];

        expect(findDifferenceIndex<int>(initial: initial, target: target), 1);
      });

      test('findDifferenceIndex, add at end', () {
        final List<int> initial = <int>[1, 2];
        const List<int> target = <int>[1, 2, 3];

        expect(findDifferenceIndex<int>(initial: initial, target: target), 2);
      });
    });

    group('findDifferenceIndex, swap', () {
      test('findDifferenceIndex, swap at start', () {
        final List<int> initial = <int>[1, 2, 3];
        const List<int> target = <int>[2, 1, 3];

        expect(findDifferenceIndex<int>(initial: initial, target: target), 0);
      });

      test('findDifferenceIndex, swap at middle', () {
        final List<int> initial = <int>[1, 2, 3, 4, 5];
        const List<int> target = <int>[1, 4, 3, 2, 5];

        expect(findDifferenceIndex<int>(initial: initial, target: target), 1);
      });

      test('findDifferenceIndex, swap at end', () {
        final List<int> initial = <int>[1, 2, 3];
        const List<int> target = <int>[1, 3, 2];

        expect(findDifferenceIndex<int>(initial: initial, target: target), 1);
      });
    });
  });
}
