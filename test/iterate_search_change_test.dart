import 'package:animated_list_view/src/utils/search_changes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('iterateSearchChanges, add', () {
    test('iterateSearchChanges, add, 1', () {
      final List<int> curr = <int>[2, 3];
      final List<int> next = <int>[1, 2, 3];

      expect(
        iterateSearchChanges<int>(
          current: curr,
          next: next,
          onAdd: (int index, int item) {
            expect(index, 0);
            expect(item, 1);
          },
          onRemove: _onRemoveFail,
        ),
        IterationResult.complete,
      );

      expect(curr, <int>[1, 2, 3]);
    });
  });

  group('iterateSearchChanges, remove', () {
    test('iterateSearchChanges, remove, 1', () {
      final List<int> curr = <int>[1, 2, 3];
      final List<int> next = <int>[2, 3];

      expect(
        iterateSearchChanges<int>(
          current: curr,
          next: next,
          onAdd: _onAddFail,
          onRemove: (int index, int item) {
            expect(index, 0);
            expect(item, 1);
          },
        ),
        IterationResult.repeat,
      );

      expect(curr, <int>[1, 2, 3]);
    });
  });

  group('iterateSearchChanges, swap', () {
    test('iterateSearchChanges, swap, 2', () {
      final List<int> curr = <int>[1, 2];
      final List<int> next = <int>[2, 1];

      expect(
        iterateSearchChanges<int>(
          current: curr,
          next: next,
          onAdd: _onAddFail,
          onRemove: (int index, int item) {
            expect(index, 0);
            expect(item, 1);
          },
        ),
        IterationResult.repeat,
      );

      expect(curr, <int>[2]);

      expect(
        iterateSearchChanges<int>(
          current: curr,
          next: next,
          onAdd: (int index, int item) {
            expect(index, 1);
            expect(item, 1);
          },
          onRemove: _onRemoveFail,
        ),
        IterationResult.complete,
      );

      expect(curr, <int>[2, 1]);
    });
  });
}

void _onAddFail(int index, int item) => fail('Should not call onAdd');

void _onRemoveFail(int index, int item) => fail('Should not call onRemove');
