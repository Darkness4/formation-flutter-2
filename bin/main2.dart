import 'dart:async';

Future<void> main2() async {
  await resultWithStream();
}

void lookForALongTime() async {
  await Future.delayed((const Duration(seconds: 2)));
}

// Part 8: Async, the part you've been (a)waiting for!
Future<String> giveMeChocolate() async {
  await lookForALongTime();
  return "🍫";
}

Future<String> giveMeWater() async {
  return "💧";
}

// Methode 1, "à la terminaison faire"
Future<void> asyncTest1() async {
  giveMeChocolate().then(print);
  giveMeWater().then(print);
}

// Methode 2, "attendre la terminaison"
Future<void> asyncTest2() async {
  Future<String> chocolate = giveMeChocolate();
  Future<String> water = giveMeWater();

  // Ordre fixé
  print(await chocolate);
  print(await water);
  // On dirait que le chocolat à terminé en premier.
  // En fait, water a terminé, mais on l'utilise plus tard.
}

// Methode 3, "synchrone"
Future<void> asyncTest3() async {
  // Faire un par un. (synchrone quoi)
  String chocolate = await giveMeChocolate();
  String water = await giveMeWater();

  // Ordre fixé
  print(chocolate);
  print(water);
}

// Exceptions
Future<String> iCanTouchYoMomTitIn2Sec() async {
  throw "🤱";
  return "d3adc0de";
}

// Méthode 1 : then
Future<void> asyncTest4() async {
  iCanTouchYoMomTitIn2Sec().catchError((e) => print("Catch $e"));
}

//Méthode 2 : try
Future<void> asyncTest5() async {
  try {
    await iCanTouchYoMomTitIn2Sec();
  } catch (e) {
    print("Catch $e");
  }
}

// Stream et Iterator
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++; // returns but do not stop
}

Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++; // returns but do not stop
}

asyncTest6() async {
  print("sync");
  for (var i in naturalsTo(5)) print(i);
  print("async");
  await for (var i in asynchronousNaturalsTo(5)) print(i);
  print("better");
  await asynchronousNaturalsTo(5).forEach((i) => print(i));
  print("way better");
  await asynchronousNaturalsTo(5).listen(print);
}

resultWithStream() async {
  asynchronousNaturalsTo(5).listen(
    print,
    onDone: () => print("End 1"),
  );
  asynchronousNaturalsTo(5).listen(
    print,
    onDone: () => print("End 2"),
  );
  asynchronousNaturalsTo(5).listen(
    print,
    onDone: () => print("End 3"),
  );
  asynchronousNaturalsTo(5).listen(
    print,
    onDone: () => print("End 4"),
  );
}

resultWithBroadcastStream() async {
  var broadcastStream = asynchronousNaturalsTo(5).asBroadcastStream();
  broadcastStream.listen(
    print,
    onDone: () => print("End 1"),
  );
  broadcastStream.listen(
    print,
    onDone: () => print("End 2"),
  );
  broadcastStream.listen(
    print,
    onDone: () => print("End 3"),
  );
  broadcastStream.listen(
    print,
    onDone: () => print("End 4"),
  );
}

// Flutter in Focus
// https://www.youtube.com/watch?v=nQBpOIHE4eE

// Last things
// typedef
typedef Compare<T> = int Function(T a, T b);
int sort(int a, int b) => a - b;

// Metadata @deprecated et @override
class Television {
  /// _Deprecated: Use [turnOn] instead._
  @deprecated
  void activate() {
    turnOn();
  }

  /// Turns the TV's power on.
  void turnOn() {}
}

// Comment (yea)
/// Documentation
///
/// Clairement un documentation, d'ailleurs [Television] a été fait par Flutter.
/// [activate] est désormais dépassé. On dit [turnOn]
/*
 * Multi-line yea
 */
