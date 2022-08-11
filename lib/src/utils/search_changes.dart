import 'find_difference_index.dart';

enum IterationResult {
  repeat,
  complete,
}

bool _isEqualDefault<T>(T a, T b) => a.runtimeType == b.runtimeType && a == b;

IterationResult iterateSearchChanges<T>({
  required List<T> initial,
  required List<T> target,
  void Function(int index, T item)? onAdd,
  void Function(int index, T item)? onRemove,
  bool Function(T a, T b)? isEqual,
}) {
  isEqual ??= _isEqualDefault;

  final int diffIndex = findDifferenceIndex(initial: initial, target: target);

  if (diffIndex == -1) {
    return IterationResult.complete;
  }

  if (diffIndex < initial.length && !target.contains(initial.elementAt(diffIndex))) {
    onRemove?.call(diffIndex, initial.elementAt(diffIndex));
    initial.removeAt(diffIndex);

    return IterationResult.repeat;
  }

  final List<T> subTarget = diffIndex < target.length ? target.sublist(diffIndex + 1) : <T>[];

  if (diffIndex < initial.length &&
      subTarget.contains(initial.elementAt(diffIndex)) &&
      initial.contains(target.elementAt(diffIndex))) {
    onRemove?.call(diffIndex, initial.elementAt(diffIndex));
    initial.removeAt(diffIndex);

    return IterationResult.repeat;
  }

  if (diffIndex >= initial.length || initial.elementAt(diffIndex) != target.elementAt(diffIndex)) {
    onAdd?.call(diffIndex, target.elementAt(diffIndex));
    initial.insert(diffIndex, target.elementAt(diffIndex));

    return IterationResult.repeat;
  }

  throw StateError('Internal error, initial=$initial, target=$target');
}

void searchChanges<T>({
  required List<T> initial,
  required List<T> target,
  void Function(int index, T item)? onAdd,
  void Function(int index, T item)? onRemove,
  bool Function(T a, T b)? isEqual,
}) {
  late IterationResult iterationResult;

  do {
    iterationResult = iterateSearchChanges(
      initial: initial,
      target: target,
      onAdd: onAdd,
      onRemove: onRemove,
      isEqual: isEqual,
    );
  } while (iterationResult != IterationResult.complete);
}
