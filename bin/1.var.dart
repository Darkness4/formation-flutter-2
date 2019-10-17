void main1() {
  dynamicAssign();
  testNum();
  testBool();
  testFinalConst();
  testSpreadAndNullList();
  setTest();
  testMap();
}

// explicit
int integer = 42; // 64 bit, signed
int integerHex = 0xDEADBEEF;

// implicit
var integer2 = 42;
// bit operations work as well (>> << & |)

// dynamic == Tout est possible
dynamic wow;

// Object, que des truc de bases sont possibles.
Object notWow;

void dynamicAssign() {
  print("\ndynamicAssign()");
  print(wow); // null, valeur par défaut !
  wow = 0.0;
  print(wow); // 0.0
  wow = "Wow";
  print(wow); // Wow
  print(wow.length); // 3
  // Ce qu'il fait en fait c'est :
  // print(wow.toString());
  // Tant que toString sort un String, le dynamic n'a pas de problème.

  // Du coup, cela fonctionne :
  notWow = 0.0;
  print(notWow);
  notWow = "Wow";
  print(notWow);

  // Mais pas
  // notWow.length();  // Compiler error, length not defined.
}

// Numbers
double decimal = 0.0;
double decimalSci = 3.14e-2;

num decimal2 = 0.0;
num integer3 = 1;

void testNum() {
  print("\ntestNum()");
  if (decimal2 is int) print("decimal2 is int !");
  if (decimal2 is double) print("decimal2 is double !");
  if (integer3 is int) print("integer3 is int !");
  if (integer3 is double) print("integer3 is double !");
}

// String
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

// Bool
bool shit = true;
String fullName = '';

// Check for zero.
int hitPoints = 0;

// Check for null.
dynamic unicorn;

// Check for NaN.
double iMeantToDoThis = 0 / 0;

void testBool() {
  print("\ntestBool()");
  print(fullName.isEmpty); // true
  print(hitPoints <= 0); // true
  print(unicorn == null); // true
  print(iMeantToDoThis.isNaN); // true
}

// List
List<int> list = [1, 2, 3];
List<int> list_stupid = <int>[1, 2, 3];
// implicits
var list2 = [1, 2, 3];
var list3 = <int>[1, 2, 3];
var list4 = <int>[];
final List<int> list5 = [1, 2, 3]; // Cannot be reinstancied => pas de setter
const List<int> list6 = [1, 2, 3]; // Immutable => pas de setter

void testFinalConst() {
  print("\ntestFinalConst()");
  list5.add(1);
  try {
    list6.add(1);
  } catch (e) {
    print("list6 is const !");
  }
  // list5 = [1, 2, 3];  // Compiler error
  // list6 = [1, 2, 3];
}

void testSpreadAndNullList() {
  print("\ntestSpreadAndNullList()");
  // Spread
  final list = [1, 2, 3];
  final list2 = [0, ...list];
  print(list2); // [0, 1, 2, 3]

  // Null aware
  List<int> list3;
  final list4 = [0, ...?list3]; // [0]
  print(list4);
}

// Dart 2.3, logic in list
List<String> nav = [
  'Home',
  'Furniture',
  'Plants',
  if (1 < 2) 'Outlet',
];
List<String> listOfStrings = [
  '#0',
  for (var i in list) '#$i',
];

// Set
Set<String> halogens = {
  'fluorine',
  'chlorine',
  'bromine',
  'iodine',
  'astatine'
};
Set<String> elements = <String>{};

void setTest() {
  print("\nsetTest()");
  print(elements);
  elements.add('fluorine');
  elements.addAll(halogens);
  print(elements);
}

// Maps
Map<String, String> gifts = {
  // Key:    Value
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings',
};

//var giftsRemake = new Map();  // Old
Map giftsRemake = <String, dynamic>{}; // Classic json
void testMap() {
  print("\ntestMap()");
  giftsRemake['first'] = 'partridge';
  giftsRemake['second'] = 'turtledoves';
  giftsRemake['fifth'] = 'golden rings';
  print(giftsRemake);
}
