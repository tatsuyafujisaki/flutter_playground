import 'package:flutter/foundation.dart';

const _myTopPrivateLevelVariable = '_myTopPrivateLevelVariable';
const myTopLevelPublicVariable = 'myTopLevelPublicVariable';

class MyPublic {
  final _myPrivateVariable = '_myPrivateVariable';
  final myPublicVariable = 'myPublicVariable';

  void _myPrivateMethod() {
    debugPrint('_myPrivateMethod');
  }

  void myPublicMethod() {
    debugPrint('myPublicMethod');
  }
}

class _MyPrivate {}

void main() {
  // Top-level private variables are only accessible from within the same file.
  debugPrint(_myTopPrivateLevelVariable);
  debugPrint(myTopLevelPublicVariable);

  final myPublic = MyPublic();
  // Private instance variables can only be accessed from the same file.
  debugPrint(myPublic._myPrivateVariable);

  debugPrint(myPublic.myPublicVariable);
  // Private instance methods can only be accessed from the same file.
  myPublic
    .._myPrivateMethod()
    ..myPublicMethod();

  // Private classes can only be accessed from the same file.
  final myPrivate = _MyPrivate();
  debugPrint(myPrivate.toString());
}
