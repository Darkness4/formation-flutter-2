// Part 3 : Functions
void main2() {
  print(intFunction());
  print(intFunction2());
  print(intFunction3());
  print(intFunction4());
  print(intFunction5());
  testFunctionArgs();
  testLambdas();
}

// Forbidden
intFunction() {
  // implicit return
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

Set<int> intFunction6() => {1};

// Positionned and Named args
void complexFunction(
  bool positionned, {
  bool namedOptionnal,
  // @required bool namedOptionnalRequired,  // Flutter SDK
  bool namedOptionnalWithDefault = false,
}) {
  print("$positionned, $namedOptionnal, $namedOptionnalWithDefault");
}

void complexFunction2(bool positionned, [bool positionnedOptionnal]) {
  print("$positionned, $positionnedOptionnal");
}

void testFunctionArgs() {
  complexFunction(true); // => true, null, false
  complexFunction(true, namedOptionnal: true); // => true, true, false
  complexFunction2(true); // => true, null
  complexFunction2(true, true); // => true, true
}

bool fastLambda(bool arg) => arg;
bool Function(bool) fastLambda2 = (bool arg) => arg;

// How 'bout function in function
bool functionInFunction(bool Function(bool) func) {
  return func(true);
}

void testLambdas() {
  print(functionInFunction(fastLambda)); // => true

  // How about an anonymous function
  print(functionInFunction((bool arg) {
    return arg;
  })); // => true

  functionInFunction((bool arg) => arg);

  // Meilleur contexte
  final list = ['apples', 'bananas', 'oranges'];
  list.forEach((item) => print('${list.indexOf(item)}: $item'));
  list.forEach(print);
}

dynamic functionDoNothing() {} // Return null
