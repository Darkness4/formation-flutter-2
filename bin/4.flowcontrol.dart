// Flow control
// if, else if, else
bool isRaining() => true;
bool isSnowing() => true;

void exampleIf() {
  if (isRaining()) {
    // do
  } else if (isSnowing()) {
    // do
  } else {
    // do
  }
}

// for et while comme sur C, ou Python
List<int> collection = [0, 1, 2];
void exampleForWhile() {
  for (var i = 0; i < 5; i++) {
    // do
  }
  collection.forEach(print);
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
    if (isRaining()) break; // Escape
    // else do
  }
  // do isRaining
  for (int i = 0; i < 5; i++) {
    if (isRaining()) {
      continue; // End iteration i
    }
    print("i won't be printed because it is raining");
    // else do
  }

  // Filter then operate
  collection.where((c) => c >= 0).forEach((c) => c--);

  // switch case
  const command = 'OPEN';
  switch (command) {
    case 'CLOSED':
    case 'PENDING':
      // executeClosedAndPending();
      break;
    case 'APPROVED':
    // executeApproved();
    // break;
    case 'DENIED':
      // executeDenied();
      break;
    case 'OPEN':
      // executeOpen();
      break;
    default:
    // executeUnknown();
  }

  // Continue only if
  String text = "";
  assert(text != null);
}
