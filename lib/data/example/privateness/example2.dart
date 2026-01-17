import 'dart:developer' as developer;

import 'example1.dart';

void main() {
  // Top-level private variables are only accessible from within the same file.
  // developer.log(_myTopPrivateLevelVariable);
  developer.log(myTopLevelPublicVariable);

  final myPublic = MyPublic();
  // Private instance variables can only be accessed from the same file.
  // developer.log(myPublic._myPrivateVariable);
  developer.log(myPublic.myPublicVariable);
  // Private instance methods can only be accessed from the same file.
  // myPublic._myPrivateMethod();
  myPublic.myPublicMethod();

  // Private classes can only be accessed from the same file.
  // final myPrivate = _MyPrivate();
}
