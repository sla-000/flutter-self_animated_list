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
  isEqual ??= _isEqualDefault<T>;

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

// Find least index of difference between two lists

// -1 Not found difference
// 0 First element of next is not equal to first element of current
// N N+1 element of next is not equal to N+1 element of current
int findDifferenceIndex<T>({
  required List<T> initial,
  required List<T> target,
}) {
  int initialIndex = 0;
  for (; initialIndex < initial.length; ++initialIndex) {
    final bool targetIsShorter = initialIndex >= target.length;
    if (targetIsShorter) {
      return initialIndex;
    }

    final bool targetDiffers = initial.elementAt(initialIndex) != target.elementAt(initialIndex);
    if (targetDiffers) {
      return initialIndex;
    }
  }

  if (initialIndex < target.length) {
    return initialIndex;
  }

  return -1;
}
