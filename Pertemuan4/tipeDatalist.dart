void main() {
  var list = [1, 2, 3];
  assert(list.length == 3);
  assert(list[1] == 2);
  print(list.length);
  print(list[1]);

  list[1] = 1;
  assert(list[1] == 1);
  print(list[1]);

  final list2 = List<String?>.filled(5, null);
  list2 [1] = "Nanda";
  list2 [2] = "244107060058";
  print(list2);
}
