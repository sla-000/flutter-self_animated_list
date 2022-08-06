import 'package:flutter_test/flutter_test.dart';
import 'package:self_animated_list/src/utils/search_changes.dart';

void main() {
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

  group('iterateSearchChanges, swap', () {
    test('iterateSearchChanges, swap at start', () {
      final List<int> initial = <int>[1, 2, 3];
      const List<int> target = <int>[2, 1, 3];

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: _onAddFail,
          onRemove: (int index, int item) {
            expect(index, 0);
            expect(item, 1);
          },
        ),
        IterationResult.repeat,
      );

      expect(initial, <int>[2, 3]);

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: (int index, int item) {
            expect(index, 1);
            expect(item, 1);
          },
          onRemove: _onRemoveFail,
        ),
        IterationResult.repeat,
      );

      expect(initial, <int>[2, 1, 3]);

      expect(
        iterateSearchChanges<int>(
          initial: initial,
          target: target,
          onAdd: _onAddFail,
          onRemove: _onRemoveFail,
        ),
        IterationResult.complete,
      );

      expect(initial, <int>[2, 1, 3]);
    });
  });
}

void _onAddFail(int index, int item) => fail('Should not call onAdd, index=$index, item=$item');

void _onRemoveFail(int index, int item) => fail('Should not call onRemove, index=$index, item=$item');
