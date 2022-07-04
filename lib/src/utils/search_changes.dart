enum IterationResult {
  repeat,
  complete,
}

bool _isEqualDefault<T>(T a, T b) => a.runtimeType == b.runtimeType && a == b;

IterationResult iterateSearchChanges<T>({
  required List<T> current,
  required List<T> next,
  required void Function(int index, T item) onAdd,
  required void Function(int index, T item) onRemove,
  bool Function(T a, T b)? isEqual,
}) {
  isEqual ??= _isEqualDefault<T>;

  return IterationResult.complete;
}

void searchChanges<T>({
  required List<T> current,
  required List<T> next,
  required void Function(int index, T item) onAdd,
  required void Function(int index, T item) onRemove,
  bool Function(T a, T b)? isEqual,
}) {
  late IterationResult iterationResult;

  do {
    iterationResult = iterateSearchChanges(
      current: current,
      next: next,
      onAdd: onAdd,
      onRemove: onRemove,
      isEqual: isEqual,
    );
  } while (iterationResult != IterationResult.repeat);
}
