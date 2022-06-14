bool _isEqualDefault(dynamic a, dynamic b) =>
    a.runtimeType == b.runtimeType && a == b;

List<T> mergeChanges<T>(
  List<T> list1,
  List<T> list2, {
  bool Function(T x1, T x2) isEqual = _isEqualDefault,
}) {
  assert(list1 != null);
  assert(list2 != null);

  final List<T> rez = <T>[];

  int index1 = 0;
  int index2 = 0;

  while (index1 < list1.length && index2 < list2.length) {
    if (isEqual(list2[index2], list1[index1])) {
      rez.add(list1[index1]);
      ++index1;
      ++index2;
    } else {
      final int find2in1index =
          list1.indexWhere((T value) => isEqual(value, list2[index2]));

      final int find1in2index =
          list2.indexWhere((T value) => isEqual(value, list1[index1]));

      if (find2in1index != -1 && find1in2index == -1) {
        if (find2in1index >= index1) {
          rez.addAll(list1.sublist(index1, find2in1index));
          index1 = find2in1index;
        } else {
          rez.add(list1[index1]);
          index1++;
        }
      } else if (find2in1index == -1 && find1in2index != -1) {
        if (find1in2index >= index2) {
          rez.addAll(list2.sublist(index2, find1in2index));
          index2 = find1in2index;
        } else {
          rez.add(list1[index2]);
          index2++;
        }
      } else if (find2in1index != -1 && find1in2index != -1) {
        ++index1;
        ++index2;
      } else {
        rez.add(list1[index1++]);
        rez.add(list2[index2++]);
      }
    }
  }

  if (index1 < list1.length) {
    rez.addAll(list1.sublist(index1));
  }

  if (index2 < list2.length) {
    rez.addAll(list2.sublist(index2));
  }

  return rez;
}
