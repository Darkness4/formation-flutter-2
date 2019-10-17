import 'dart:async';

Future<void> main() async {
  await asyncTest4();
}

// Part 8: Async, the part you've been (a)waiting for!
// Voir diapo
Future<String> giveMeChocolate() async {
  await Future<void>.delayed(const Duration(seconds: 2));
  return "🍫";
}

Future<String> giveMeWater() async {
  return "💧";
}

// Methode 1, "à la terminaison faire"
void asyncTest1() {
  giveMeChocolate().then(print);
  giveMeWater().then(print);
}

// PB:
void asyncPB() {
  String lent;
  String rapide;
  giveMeChocolate().then((sortie) => rapide = lent);
  giveMeWater().then((sortie) => rapide = sortie);

  print(lent);
  print(rapide);
}

// Methode 2, "synchrone"
Future<void> asyncTest2() async {
  // Faire un par un. (synchrone quoi)
  final String chocolate = await giveMeChocolate();
  final String water = await giveMeWater();

  // Ordre fixé
  print(chocolate);
  print(water);
}

// Methode 3, "attendre la terminaison"
Future<void> asyncTest3() async {
  final Future<String> chocolate = giveMeChocolate();
  final Future<String> water = giveMeWater();

  // Ordre fixé
  print(await chocolate);
  print(await water);
  // On dirait que le chocolat à terminé en premier.
  // En fait, water a terminé, mais on l'utilise plus tard.
}

// Methode 4, "En même temps"
Future<void> asyncTest4() async {
  final Future<String> chocolate = giveMeChocolate();
  final Future<String> water = giveMeWater();

  // Ordre fixé
  print(await Future.wait([chocolate, water]));
}

// Exceptions
Future<void> iCanTouchYoMomTitIn2Sec() async {
  throw Exception("🤱");
}

// Méthode 1 : then
Future<void> asyncTest5() async {
  await iCanTouchYoMomTitIn2Sec().catchError(print);
}

//Méthode 2 : try
Future<void> asyncTest6() async {
  try {
    await iCanTouchYoMomTitIn2Sec();
  } catch (e) {
    print("Catch $e");
  }
}

// Stream et Iterator
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) {
    yield k++; // returns but do not stop
  }
}

Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) {
    yield k++; // returns but do not stop
  }
}

Future<void> asyncTest7() async {
  print("sync");
  naturalsTo(5).forEach(print);
  print("async");
  await asynchronousNaturalsTo(5).forEach(print);
  print("way better (play in background)");
  final StreamSubscription<int> subscription =
      asynchronousNaturalsTo(5).listen(print);
  await subscription.cancel();
}

Future<void> resultWithStream() async {
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

Future<void> resultWithBroadcastStream() async {
  final broadcastStream = asynchronousNaturalsTo(5).asBroadcastStream();
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
  @Deprecated("Use [turnOn] instead.")
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
