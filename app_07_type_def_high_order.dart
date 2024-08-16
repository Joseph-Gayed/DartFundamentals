typedef MyMapOfLists<X> = Map<X, List<X>>;
typedef MyOperation = void Function(int x, int y);

void main() {
  Map<String, List<String>> map1 = {
    "key1": ["value1.1", "value1.2"],
    "key2": ["value2.1", "value2.2"],
  }; 
  // Same thing but shorter and clearer.
  MyMapOfLists<String> map2 = {
    "key1": ["value1.1", "value1.2"],
    "key2": ["value2.1", "value2.2"],
  }; 


  MyOperation addOPeration = add;
  void Function(int x, int y) subOperation = subtract;

  calculate(5, 5, addOPeration);
  calculate(5, 5, subOperation);
  calculate(5, 5, divide);
  calculate(5, 5, multiply);
}

add(int firstNo, int second) {
  print("Add result is ${firstNo + second}");
}

subtract(int firstNo, int second) {
  print("Subtract result is ${firstNo - second}");
}

divide(int firstNo, int second) {
  print("Divide result is ${firstNo / second}");
}

multiply(int firstNo, int second) {
  print("multiply result is ${firstNo * second}");
}

//high order function
void calculate(int input1, int input2, MyOperation operation) {
  operation(input1, input2);
}

//high order function
void myPrint(int input1, int input2, MyOperation printing) {
  if (input1 > 0 && input2 > 0) {
    printing(input1, input2);
  }
}
