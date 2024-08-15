import 'dart:async';

void main(List<String> args) {
  print("Main-Strart");
  event1;
  event2;
  event3;
  microTask1;
  microTask2;
  microTask3;
  print("Main-End");
}
//MicroTasks Queue
var microTask1 = scheduleMicrotask(() => print("microTask #1"));
var microTask2 = scheduleMicrotask(() => print("microTask #2"));
var microTask3 = scheduleMicrotask(() => print("microTask #3"));

//EventsQueue
var event1 = Future(() => print("event #1"));
var event2 = Future.delayed(Duration(seconds: 4), () => print("event #2"));
var event3 = Timer(Duration(seconds: 5), () => print("event #3"));
