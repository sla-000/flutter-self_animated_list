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
