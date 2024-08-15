T1 genericMethod1<T1, T2>(T1 value1, T2 value2) {
  return value1;
}


(T1,T2) genericMethod2<T1, T2>(T1 value1, T2 value2) {
  return (value1,value2);
}


void main() {
  // call the generic method
  print(genericMethod1<int, String>(10, "Hello"));
  print(genericMethod1<String, int>("Hello", 10));
  print(genericMethod2<String, int>("Hello", 10));
}