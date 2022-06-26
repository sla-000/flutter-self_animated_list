enum ChangeType {
  none,
  add,
  remove,
}

bool _isEqualDefault<T>(T a, T b) => a.runtimeType == b.runtimeType && a == b;

ChangeType calcChangeType<T>(int index, List<T> previousData, List<T> currentData) {
  return ChangeType.none;
}
