import 'package:flutter/foundation.dart';

import 'example1.dart';

void main() {
  // Top-level private variables are only accessible from within the same file.
  // debugPrint(_myTopPrivateLevelVariable);
  debugPrint(myTopLevelPublicVariable);

  final myPublic = MyPublic();
  // Private instance variables can only be accessed from the same file.
  // debugPrint(myPublic._myPrivateVariable);
  debugPrint(myPublic.myPublicVariable);
  // Private instance methods can only be accessed from the same file.
  // myPublic._myPrivateMethod();
  myPublic.myPublicMethod();

  // Private classes can only be accessed from the same file.
  // final myPrivate = _MyPrivate();
}
