import '1.var.dart';
import '2.func.dart' as main2;
import '3.operators.dart' show main3;
import '6.classes.dart' hide doSomeClasses, doSomeClasses2;

// Define
void printNumber(int aNumber) {
  print('The number is $aNumber');
  print("The number is $aNumber");
}

// Main
void main(List<String> arguments) {
  var number = 42; // Implicit
  printNumber(42);
  main1();
  main2.main2();
  main3();
  main5();
}
