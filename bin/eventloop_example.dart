import 'dart:io';

Future<String> function1Longue() async {
  await Future<void>.delayed(const Duration(seconds: 1));
  return "1";
}

String function2Longue() {
  sleep(const Duration(milliseconds: 700));
  return "2";
}

Future<String> function2LongueAsync() async {
  await Future<void>.delayed(const Duration(milliseconds: 700));
  return "2";
}

Future<String> function3Short() async {
  await Future<void>.delayed(const Duration(milliseconds: 500));
  return "3";
}

void main(List<String> args) {
  /// Call (add to callstack)
  function1Longue().then(print);
  final String value2 = function2Longue();
  print(value2); // Stuck
  function2LongueAsync().then(print);
  function3Short().then(print);
}
