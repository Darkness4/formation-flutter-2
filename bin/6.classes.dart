// Part 6 : Classes
void main5() {
  doSomeClasses3();
}

class Point {
  // Class member
  int x;
  int y;
}

void doSomeClasses() {
  final p = Point();
  p.y = 3;
  p.x = 3;

  p?.x = 2; // is p not null ? if so, p = 2, else jump.
}

// Immutable
class ImmutablePoint {
  // Need to be instancied (via constructor)
  final int x;
  final int y;

  const ImmutablePoint(this.x, this.y); // Constructor
}

void doSomeClasses2() {
  const a = ImmutablePoint(1, 1);
  const b = ImmutablePoint(1, 1);

  assert(identical(a, b)); // They are the same instance!
}

// Only one const, which establishes the constant context.
const pointAndLine = {
  'point': [ImmutablePoint(0, 0)],
  'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};

class SuperPoint {
  // Privates
  final int _x;
  final int _y;

  // Getters
  int get x => _x;
  int get y => _y;

  // Shared to all instances (class variables)
  static final List<SuperPoint> _cache = <SuperPoint>[];

  SuperPoint(this._x, this._y) {
    _cache.add(this); // body
  } // Constructor

  // factory, return an instance.
  factory SuperPoint.withoutClones(int x, int y) {
    final cachedPoint =
        _cache.firstWhere((point) => point.x == x && point.y == y);
    if (cachedPoint == null) {
      final newPoint = SuperPoint(x, y);
      _cache.add(newPoint);
      return newPoint;
    } else {
      return cachedPoint ?? SuperPoint(x, y); // If not exists, add yours !
    }
  }

  SuperPoint.doubleDistance(int x, int y)
      : _x = x * 2, // member initializer list
        _y = y * 2 {
    _cache.add(this); // body
  } // Named constructor with some effets
}

void doSomeClasses3() {
  SuperPoint p = SuperPoint(1, 1);
  SuperPoint pSame = SuperPoint.withoutClones(1, 1);
  print(p == pSame); // true
  SuperPoint p2 = SuperPoint.doubleDistance(1, 1);
  print("${p.x}, ${p.y}"); // 1, 1
  print("${p2.x}, ${p2.y}"); // 2, 2
}

// Inheritance
class BetterPoint extends SuperPoint {
  final int _z;

  int get z => _z;

  BetterPoint({int x, int y, int z}) // Named parameters
      : assert(x != null), // Parameters must not be null
        assert(y != null), // Use @required for Flutter SDK
        assert(z != null),
        _z = z,
        super(x, y);
}

void doSomeClasses4() {
  final p = BetterPoint(
    x: 0,
    y: 1,
    z: 2,
  );
  print("${p.x}, ${p.y}, ${p.z}"); // 0, 1, 2
}

class PrecisePoint {
  double x;
  double y;

  set increaseX(double length) => x += length;
  set increaseY(double length) => y += length;

  PrecisePoint(this.x, this.y); // Constructor
}

void doSomeClasses5() {
  final p = PrecisePoint(0.0, 0.0);
  p.x = 2;
  print("${p.x}, ${p.y}"); // 2.0, 0.0

  p.increaseX = 2;
  print("${p.x}, ${p.y}"); // 4.0, 0.0
}

// abstract : Ne peut être une instance
// Utile pour les interfaces
abstract class MyCustomStatelessWidget {
  final String key;

  const MyCustomStatelessWidget({this.key: ""});

  // abstract method
  String build(String context);
}

// Extends: La class hérite des attributs de MyCustomStatelessWidget
class Exemple extends MyCustomStatelessWidget {
  const Exemple({String key}) : super(key: key);

  @override
  String build(String context) {
    return """Container(
      child: child,
    );""";
  }
}

// Implement: La classe doit posséder les mêmes attributs que MyCustomStatelessWidget
class Exemple2 implements MyCustomStatelessWidget {
  @override
  final String key;

  const Exemple2({this.key});

  @override
  String build(String context) {
    return """Container(
      child: child,
    );""";
  }
}

// Mixin, pas d'inheritance, juste DES ajouts (au pluriels)
mixin RightArm {
  String rightWeapon;

  void useRightWeapon() {}
}

mixin LeftArm {
  String leftWeapon;

  void useLeftWeapon() {}
}

// Dependance only on extended Human
mixin RightWeapon on Human {
  void useSpecialRight() {}
}

class Human with RightArm, LeftArm {
  void fight() {
    useRightWeapon();
    useLeftWeapon();
  }
}

class SpecialHuman extends Human with RightWeapon {
  @override
  void fight() {
    useSpecialRight();
    super.fight();
  }
}

class MyCollection {
  // Class variable
  static String address = "127.0.0.1";

  // Class method
  static void printAddress() => print(address);
}

// Enum
enum Colors { red, green, blue }

void doSomeEnum() {
  const Colors color = Colors.red;
  switch (color) {
    case Colors.red:
      // do
      break;

    case Colors.green:
      // do
      break;

    case Colors.blue:
      // do
      break;
  }
}

// Generics (ou Template en C++)
// Useless
void showInt(int object) {
  print(object);
}

void showString(String object) {
  print(object);
}

// Better
void show<T>(T object) {
  print(object);
}

// Way better
void showBetter<T extends Object>(T object) {
  // object = dynamic
  print(object);
}

void showSubHuman<T extends Human>(T object) {
  object.fight();
}
