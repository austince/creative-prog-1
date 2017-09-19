boolean isDebugging = true;

void debug(Object ...args) {
  if (isDebugging) {
    println(args);
  }
}

void debugArray(Iterable arr) {
  if (isDebugging) {
    printArray(arr);
  }
}