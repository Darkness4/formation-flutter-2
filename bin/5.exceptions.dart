// Part 5 : Exceptions
void doSomeErrors() {
  bool iBurn() => true;
  void putWater() {}
  try {
    if (iBurn()) {
      throw MyException();
    } else {
      throw Exception("I'm not burning...");
    }
  } on MyException catch (e) {
    print(e); // I burn !
  } catch (e, s) {
    print("Yep, i'm not burning.");
    print('Exception details:\n $e');
    print('Stack trace:\n $s');
  } finally {
    putWater();
  }
}

class MyException implements Exception {
  @override
  String toString() {
    return "I Burn!";
  }
}
