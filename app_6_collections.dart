void main() {
  var studentsNames = ["name1", "name1", "name3", "name2"];
  print("----------------");
  print("List example");
  studentsNames.forEach(print);

  print("----------------");
  print("cost List Example");
  var constStudentNames = const ["name1", "name1", "name3", "name2"];
  //constStudentNames.add("name5");

  print("----------------");
  print("Set example");
  var uniqueStudents = {"name1", "name1", "name3", "name2"};
  uniqueStudents.forEach(print);
  print("----------------");
  print("Set from List example");
  var uniqueStudentsName = removeDuplicates(studentsNames);
  // uniqueStudentsName = studentsNames.toSet();
  uniqueStudentsName.forEach(print);

  var studentsIds = [1, 2, 3, 2, 3, 5, 5, 6];
  var uniqueStudentsIds = removeDuplicates(studentsIds);
  uniqueStudentsIds.forEach(print);
  print("----------------");

  Map<String, String> studentInfo = {
    "Mohamed": "IS",
    "hossam": "IT",
    "Abdo": "CS"
  };
  studentInfo["Haridi"] = "CS";
  studentInfo["7'alaf"] = "IT";
  studentInfo["Mohamed"] = "IT";

  print(studentInfo["Mohamed"]);
  studentInfo.forEach((K,V)=>print("$K : $V"));
  studentInfo.forEach(mapPrinter);


  print("----------------");
  print("Spread Example");

  List<int> idsOfGroupA = [1, 2, 3];
  List<int> idsOfGroupB = [4, 5, 6,5 ,6,8,5,8,5,69];
  List<int>? idsOfGroupC;
  List<int> idsOfAllGroups = [...idsOfGroupA, ...idsOfGroupB, ...?idsOfGroupC];

  idsOfAllGroups.forEach(print);
}

Set<T> removeDuplicates<T>(List<T> inputList) {
  print("----------------");
  print("Convert List to Set using generic method");
  return inputList.toSet();
}

void mapPrinter<K, V>(K key, V value) {
  print("$key : $value");
}
