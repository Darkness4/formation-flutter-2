// Part 4 : Operators

void main3() {
  testNull();
}

int i = 0;
int imNull;
void doSomeOperators() {
  ++i;
  i++;
  --i;
  i--;
  print(i is double ? true : false);
  // Et tout les equals operators
  // =	–=	/=	%=	>>=	^=
  // +=	*=	~/=	<<=	&=	|=

  // bool
  // ! || &&

  dynamic value;
  value = 32;
  (value as int).ceil(); // Le 'as' permet l'autocompletion.

  // bitwise
  // &	AND
  // |	OR
  // ^	XOR
  // ~expr	Unary bitwise complement (0s become 1s; 1s become 0s)
  // <<	Shift left
  // >>

  // Null test
  imNull ??= 32; // Assign if null
  final value2 = imNull ?? 64; // Value = 32
  final value3 = null ?? 64; // Assign left if left !null else assign  64
}

// Cascade operation (for style)
class Operations {
  String name;
  String date;

  void operation1() {}
  void operation2() {}
}

Operations operations = Operations()
  ..date = "06/06/06"
  ..name = "operation satanique"
  ..operation1()
  ..operation2();

void testNull() {
  Operations opNull;
  String date;
  try {
    date = opNull.date;
  } catch (e) {
    print(e);
  }
  date = opNull?.date; // Pas d'erreur d'exception, null obtenu
  print(date);
}
