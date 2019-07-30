// Partie 1 : La base
import 'main2.dart';

printShit(int aNumber) {
  print('The number is $aNumber');
  print("The number is $aNumber");
}

main(List<String> arguments) {
  var number = 42;
  printShit(42);
  doSomeOperators();
  main2();
}

// Partie 2 : Les types
// explicit
int integer = 42; // 64 bit, signed
int integerHex = 0xDEADBEEF;

// implicit
var integer2 = 42;
// bit operations work as well (>> << & |)

// dynamic
var wow;
dynamic wow2;
doSmth0() {
  wow = 0.0;
  wow = "shit";
  wow2 = 0.0;
  wow2 = "$wow";
}

double decimal = 0.0;
double decimalSci = 3.14e-2;

num decimal2 = 0.0;
num integer3 = 1;

String s1 = 'Single quotes work well for string literals.';
String s2 = "Double quotes work just as well.";
String s3 = 'It\'s easy to escape the string delimiter.';
String s4 = "It's even easier to use the other delimiter.";
String s5 = 'String '
    'concatenation'
    " works even over line breaks.";
String s6 = '''
You can create
multi-line strings like this one.
''';
String s = r'In a raw string, not even \n gets special treatment.';

bool shit = true;

List<int> list = [1, 2, 3];
List<int> list_stupid = <int>[1, 2, 3]; // wow
// implicits
var list2 = [1, 2, 3];
var list3 = <int>[1, 2, 3];
var list4 = <int>[]; // Beaucoup plus intéressant
// Dart 2.3
bool shitHappens = true;
var nav = ['Home', 'Furniture', 'Plants', if (shitHappens) 'Outlet'];
var listOfStrings = ['#0', for (var i in list) '#$i'];

// Set
var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
var elements = <String>{};
doSmth() {
  elements.add('fluorine');
  elements.addAll(halogens);
}

// Maps
var gifts = {
  // Key:    Value
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings',
};

//var giftsRemake = new Map();  // Old
var giftsRemake = Map();
doSmth2() {
  giftsRemake['first'] = 'partridge';
  giftsRemake['second'] = 'turtledoves';
  giftsRemake['fifth'] = 'golden rings';
}

// Finally final, const, static
// final : Must be initialized and cannot be changed
final mapInitialized = Map();
// static : Disponible directement via la classe, sans passer par une instance
// const : Constante.
const espace = ' ';

// Meilleur contexte, dans un objet via un constructeur
class gatherInfo {
  final Map _mapInitialized;
  static const couleur = 'rouge';
  var couleur2 = 'verte';

  gatherInfo(this._mapInitialized); // Constructor
}

doSmth3() {
  // Appel du static
  print("${gatherInfo.couleur}");

  // Appel du final
  var infoGatherer = gatherInfo(mapInitialized);
  print("${infoGatherer.couleur2}");
}

// Part 3 : Functions
intFunction() {
  // Return un dynamic !
  return 1;
}

// Egal à
dynamic intFunction2() {
  return 1;
}

// N'est pas égal à
int intFunction3() {
  return 1;
}

// Egal à
intFunction4() => 1;

// N'EST PAS DU TOUT EGAL A
intFunction5() => {1}; // Return un Set {1}

// Positionned and Named args
void complexFunction(bool positionned,
    {bool namedOptionnal, bool namedOptionnalWithDefault: false}) {
  print("$positionned, $namedOptionnal, $namedOptionnalWithDefault");
}

// complexFunction(true);  // => true, null, false
// complexFunction(true, namedOptionnal: true);  // => true, true, false

// How 'bout function in function
void FinF(Function func) {
  func(true);
}

void doSmthFFS() {
  FinF(complexFunction); // => true, null, false

  // HOW 'BOUT A ANONYMOUS FUNCTION
  FinF((bool arg) => print(arg)); // => true

  var list = ['apples', 'bananas', 'oranges'];
  list.forEach((item) => print('${list.indexOf(item)}: $item'));
}

// Part 4 : Operators
// import 'dart:html' as html;
int i = 0;
int imNull = null;
void doSomeOperators() {
  ++i;
  i++;
  --i;
  i--;
  print(i is double ? true : false);
  imNull ??= 32; // Assign if null
  // Et tout les equals operators
  // =	–=	/=	%=	>>=	^=
  // +=	*=	~/=	<<=	&=	|=

  // bool
  // ! || &&

  // bitwire
  // &	AND
  // |	OR
  // ^	XOR
  // ~expr	Unary bitwise complement (0s become 1s; 1s become 0s)
  // <<	Shift left
  // >>

  // Null test
  var value = imNull ?? 64; // Value = 32
  var value2 = null ?? 64; // Value = 64
}

// Cascade operation (for style)
class Operations {
  String name;
  String date;

  void operation1() {}
  void operation2() {}
}

var operations = Operations()
  ..date = "06/06/06"
  ..name = "operation satanique"
  ..operation1()
  ..operation2();

// Flow control
// if, else if, else
isRaining() => true;
isSnowing() => true;

exampleIf() {
  if (isRaining()) {
    // do
  } else if (isSnowing()) {
    // do
  } else {
    // do
  }
}

// for et while comme sur C, ou Python
var collection = [0, 1, 2];
exampleForWhile() {
  for (var i = 0; i < 5; i++) {
    // do
  }
  collection.forEach((i) {
    //do
  });
  for (var x in collection) {
    print(x); // 0 1 2
  }
  while (isRaining()) {
    // do
  }
  do {
    // do
  } while (isRaining());
  while (true) {
    if (isRaining()) break;
    // else do
  }
  // do isRaining
  for (int i = 0; i < 5; i++) {
    if (isRaining()) {
      continue; // End iteration i
    }
    // else do
  }

  // Filter then operate
  collection.where((c) => c >= 0).forEach((c) => c--);

  // switch case
  // won't do that
}

// Part 5 : Exceptions
doSomeErrors() {
  iBurn() => true;
  putWater() {}
  ;
  try {
    if (iBurn()) throw Exception("I Burn !");
    print("i'm not burning");
  } on Exception catch (e) {
    print(e.toString());
  } catch (e, s) {
    print("idk error");
    print('Exception details:\n $e');
    print('Stack trace:\n $s');
  } finally {
    putWater();
  }
}

// Part 6 : Classes
class Point {
  int x;
  int y;
}

doSomeClasses() {
  var p = Point();
  p.y = 3;
  p.x = 3;

  p?.x = 2; // is p not null ? if so, p = 2, else jump.
}

// Immutable
class ImmutablePoint {
  final int x;
  final int y;

  const ImmutablePoint(this.x, this.y); // Constructor
}

doSomeClasses2() {
  var a = const ImmutablePoint(1, 1);
  var b = const ImmutablePoint(1, 1);

  assert(identical(a, b)); // They are the same instance!
}

// Lots of const keywords here.
const pointAndLine = const {
  'point': const [const ImmutablePoint(0, 0)],
  'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};

// Only one const, which establishes the constant context.
const pointAndLine2 = {
  'point': [ImmutablePoint(0, 0)],
  'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};

// Named constructor
class SuperPoint {
  final int _x;
  final int _y;

  // Getters
  int get x => _x;
  int get y => _y;

  const SuperPoint(this._x, this._y); // Constructor

  const SuperPoint.doubleDistance(int x, int y)
      : _x = x * 2,
        _y = y * 2; // Named constructor with some effets
}

doSomeClasses3() {
  const p = SuperPoint(1, 1);
  const p2 = SuperPoint.doubleDistance(1, 1);
  print("${p.x}, ${p.y}"); // 1, 1
  print("${p2.x}, ${p2.y}"); // 2, 2
}

// Inheritance
class BetterPoint extends SuperPoint {
  final int _z;

  int get z => _z;

  const BetterPoint({int x, int y, int z}) // Named parameters
      : assert(x != null), // Parameters must not be null
        assert(y != null),
        assert(z != null),
        _z = z,
        super(x, y);
}

doSomeClasses4() {
  const p = BetterPoint(
    x: 0,
    y: 1,
    z: 2,
  );
  print("${p.x}, ${p.y}, ${p.z}"); // 0, 1, 2
}

class PrecisePoint {
  double _x;
  double _y;

  double get x => _x;
  double get y => _y;

  set x(double xArg) => _x = xArg;
  set y(double yArg) => _y = yArg;

  set increaseX(double length) => _x += length;
  set increaseY(double length) => _x += length;

  PrecisePoint(this._x, this._y); // Constructor
}

doSomeClasses5() {
  var p = PrecisePoint(0.0, 0.0);
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
  final String key;

  const Exemple2({String this.key});

  String build(String context) {
    return """Container(
      child: child,
    );""";
  }
}

// Enum
enum Colors { red, green, blue }

doSomeEnum() {
  Colors color = Colors.red;
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

// mixin (ou abstract class en plus classe)
// ain't gonna do that

// Part 7 : Generics
// ain't gonna do that
// But 'tis <dis type righ' thar>[]. Exemple <int>[], <String>[]
