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

      test('findDifferenceIndex, remove at end', () {
        final List<int> initial = <int>[1, 2, 3];
        const List<int> target = <int>[1, 3, 2];

        expect(findDifferenceIndex<int>(initial: initial, target: target), 1);
      });
    });
  });

  group('iterateSearchChanges, add', () {
    test('iterateSearchChanges, add, empty', () {
      final List<int> initial = <int>[];
      const List<int> target = <int>[1];

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: (int index, int item) {
            expect(index, 0);
            expect(item, 1);

            initial.insert(index, item);
          },
          onRemove: _onRemoveFail,
        ),
        IterationResult.repeat,
      );

      expect(initial, <int>[1]);

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: _onAddFail,
          onRemove: _onRemoveFail,
        ),
        IterationResult.complete,
      );

      expect(initial, <int>[1]);
    });

    test('iterateSearchChanges, add, 1 at start', () {
      final List<int> initial = <int>[2, 3];
      const List<int> target = <int>[1, 2, 3];

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: (int index, int item) {
            expect(index, 0);
            expect(item, 1);

            initial.insert(index, item);
          },
          onRemove: _onRemoveFail,
        ),
        IterationResult.repeat,
      );

      expect(initial, <int>[1, 2, 3]);

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: _onAddFail,
          onRemove: _onRemoveFail,
        ),
        IterationResult.complete,
      );

      expect(initial, <int>[1, 2, 3]);
    });

    test('iterateSearchChanges, add, 1 at end', () {
      final List<int> initial = <int>[1, 2];
      const List<int> target = <int>[1, 2, 3];

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: (int index, int item) {
            expect(index, 2);
            expect(item, 3);

            initial.insert(index, item);
          },
          onRemove: _onRemoveFail,
        ),
        IterationResult.repeat,
      );

      expect(initial, <int>[1, 2, 3]);

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: _onAddFail,
          onRemove: _onRemoveFail,
        ),
        IterationResult.complete,
      );

      expect(initial, <int>[1, 2, 3]);
    });

    test('iterateSearchChanges, add, many', () {
      final List<int> initial = <int>[2, 4];
      const List<int> target = <int>[1, 2, 3, 4, 5];

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: (int index, int item) {
            expect(index, 0);
            expect(item, 1);

            initial.insert(index, item);
          },
          onRemove: _onRemoveFail,
        ),
        IterationResult.repeat,
      );

      expect(initial, <int>[1, 2, 4]);

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: (int index, int item) {
            expect(index, 2);
            expect(item, 3);

            initial.insert(index, item);
          },
          onRemove: _onRemoveFail,
        ),
        IterationResult.repeat,
      );

      expect(initial, <int>[1, 2, 3, 4]);

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: (int index, int item) {
            expect(index, 4);
            expect(item, 5);

            initial.insert(index, item);
          },
          onRemove: _onRemoveFail,
        ),
        IterationResult.repeat,
      );

      expect(initial, <int>[1, 2, 3, 4, 5]);

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: _onAddFail,
          onRemove: _onRemoveFail,
        ),
        IterationResult.complete,
      );

      expect(initial, <int>[1, 2, 3, 4, 5]);
    });
  });

  group('iterateSearchChanges, remove', () {
    test('iterateSearchChanges, remove, 1', () {
      final List<int> initial = <int>[1, 2, 3];
      const List<int> target = <int>[2, 3];

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: _onAddFail,
          onRemove: (int index, int item) {
            expect(index, 0);
            expect(item, 1);

            initial.removeAt(index);
          },
        ),
        IterationResult.repeat,
      );

      expect(initial, <int>[2, 3]);

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: _onAddFail,
          onRemove: _onRemoveFail,
        ),
        IterationResult.complete,
      );

      expect(initial, <int>[2, 3]);
    });

    test('iterateSearchChanges, remove, few', () {
      final List<int> initial = <int>[1, 2, 3, 4, 5];
      const List<int> target = <int>[1, 3];

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: _onAddFail,
          onRemove: (int index, int item) {
            expect(index, 1);
            expect(item, 2);

            initial.removeAt(index);
          },
        ),
        IterationResult.repeat,
      );

      expect(initial, <int>[1, 3, 4, 5]);

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: _onAddFail,
          onRemove: (int index, int item) {
            expect(index, 2);
            expect(item, 4);

            initial.removeAt(index);
          },
        ),
        IterationResult.repeat,
      );

      expect(initial, <int>[1, 3, 5]);

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: _onAddFail,
          onRemove: (int index, int item) {
            expect(index, 2);
            expect(item, 5);

            initial.removeAt(index);
          },
        ),
        IterationResult.repeat,
      );

      expect(initial, <int>[1, 3]);

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: _onAddFail,
          onRemove: _onRemoveFail,
        ),
        IterationResult.complete,
      );

      expect(initial, <int>[1, 3]);
    });
  });

  // group('iterateSearchChanges, swap', () {
  //   test('iterateSearchChanges, swap, 2', () {
  //     final List<int> initial = <int>[1, 2];
  //     const List<int> target = <int>[2, 1];
  //
  //     expect(
  //       iterateSearchChanges<int>(
  //         current: initial,
  //         target: target,
  //         onAdd: _onAddFail,
  //         onRemove: (int index, int item) {
  //           expect(index, 0);
  //           expect(item, 1);
  //         },
  //       ),
  //       IterationResult.repeat,
  //     );
  //
  //     expect(initial, <int>[2]);
  //
  //     expect(
  //       iterateSearchChanges<int>(
  //         current: initial,
  //         target: target,
  //         onAdd: (int index, int item) {
  //           expect(index, 1);
  //           expect(item, 1);
  //         },
  //         onRemove: _onRemoveFail,
  //       ),
  //       IterationResult.complete,
  //     );
  //
  //     expect(initial, <int>[2, 1]);
  //   });
  // });
}

void _onAddFail(int index, int item) => fail('Should not call onAdd, index=$index, item=$item');

void _onRemoveFail(int index, int item) =>
    fail('Should not call onRemove, index=$index, item=$item');
