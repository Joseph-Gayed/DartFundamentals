import 'dart:async';
import 'dart:math';

void main(List<String> args) {
  runZonedGuarded(unSafeMain, catchUnHandledExceptions);
  // print("-------------");
  //runZonedGuarded(safeFunction, catchUnHandledExceptions);
}

void unSafeMain(){
  // riskyFunction();

  //  try {
  //   riskyFunction();
  // } catch (e) {
  //   print('Caught in try-catch: $e');
  // }

  safeFunction();
}


void riskyFunction() {
  int result = 0;
  result = "try parse 25" as int;
  // result = 12 ~/ 0; // ~/: similar to (12/0).toInt();
  print('The result is $result');
}

void safeFunction() {
  try {
    riskyFunction();
  } on TypeError {
    print('From safeFunction: Parsing Exception ,  casting is not correct');
    rethrow; //propagate the error to the caller. This line makes the function not safe.
  } on UnsupportedError {
    print(
        'From safeFunction: The exception thrown is UnsupportedError can not divide by 0');
  } catch (e) {
    print('From safeFunction: An UNKNOWN error occurred: $e');
  } finally {
    print('From safeFunction: finally');
  }
}

void catchUnHandledExceptions(Object error, StackTrace stack) {
  print("From Zoned Guareded: Handled the UnCaught exception $error");
}
