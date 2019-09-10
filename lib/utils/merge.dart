bool _isEqualDefault(a, b) => a.runtimeType == b.runtimeType && a == b;

List<T> mergeChanges<T>(
  List<T> list1,
  List<T> list2, {
  bool Function(T x1, T x2) isEqual = _isEqualDefault,
}) {
  assert(list1 != null);
  assert(list2 != null);

  final rez = <T>[];

  var index1 = 0;
  var index2 = 0;

  while (index1 < list1.length && index2 < list2.length) {
    if (isEqual(list2[index2], list1[index1])) {
      rez.add(list1[index1]);
      ++index1;
      ++index2;
    } else {
      final find2in1index =
          list1.indexWhere((value) => isEqual(value, list2[index2]));

      final find1in2index =
          list2.indexWhere((value) => isEqual(value, list1[index1]));

      if (find2in1index != -1 && find1in2index == -1) {
        rez.addAll(list1.sublist(index1, find2in1index));
        index1 = find2in1index;
      } else if (find2in1index == -1 && find1in2index != -1) {
        rez.addAll(list2.sublist(index2, find1in2index));
        index2 = find1in2index;
      } else if (find2in1index != -1 && find1in2index != -1) {
//        debugPrint(
//            "mergeChanges: Found collision,\nlist1=$list1,\nlist2=$list2");
        ++index1;
        ++index2;
      } else {
//        debugPrint("mergeChanges: Unique chunk,\nlist1=$list1,\nlist2=$list2");
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
