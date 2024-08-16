late String studentName;
const String universityName = "Ain-Shams University"; //compile time
dynamic studentScore;

String getCourseNameInRunTime() {
  return "Java";
}

void main(List<String> args) {
  //var can only change value without changing datatype
  var studentId = 123; // studentId is of type int.
  studentId = 456; // changing value of studentId from 123 to 456.
  //studentId = 'abc'; // ERROR: can't change type of v from int to String.

  //late
  studentName = "Jo";

  //dynamic datatype can change value and type
  studentScore = 90;
  studentScore = "98%";
  studentScore = 95.5;

  final String courseName =
      getCourseNameInRunTime(); // courseName is of type String.
  // courseName = 456; // ERROR: can't change value of courseName.
  // courseName = 'abc'; // ERROR: can't change datatype of courseName.

  //final object can change attributes , but can't change instance
  final User u1 = User(1, "Jo");
  u1.id = 2;
  u1.name = "Joseph";
//u1 = User(2, "Joseph");; // ERROR: can't give u1 new instance

  const cu1 = ConstUser(1,
      "Jo"); //const can't change attributes,constusructor must be const and all attributes must be final
  //cu1.name = "Joseph" //error
}

class User {
  int id;
  String name;
  User(this.id, this.name);
}

class ConstUser {
  final int id;
  final String name;
  const ConstUser(this.id, this.name);
}
