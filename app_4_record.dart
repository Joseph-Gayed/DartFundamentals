//Record

void main(List<String> args) {
  //Declare a Record
  var record1 = ('first', a: 2, b: true, 'last', 21.5);
  (String, int, bool) record2 = ('first', 2, true);

  //Use a Record
  //For the not named parameters: use the $ operator then index(starting from 1). example: $1, $2
  print(record1.$1); //print 'first' // print 'true'
  print(record1.$2); //print 'last'
  print(record1.$3); //print 'last'

  //For the named parameters: use the . then parameter name. example: .a, .b
  print(record1.a); // print '2'
  print(record1.b);


  
final json = <String, dynamic>{
  'name': 'Dash',
  'age': 10,
  'color': 'blue',
};

// Destructures using a record pattern with positional fields:
var (name, age) = userInfo(json);

/* Equivalent to:
  var info = userInfo(json);
  var name = info.$1;
  var age  = info.$2;
*/
print("$name , $age");
}


// Returns multiple values in a record:
(String name, int age) userInfo(Map<String, dynamic> json) {
  return (json['name'] as String, json['age'] as int);
}