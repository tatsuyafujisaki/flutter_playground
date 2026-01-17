import 'dart:developer' as developer;

const _myTopPrivateLevelVariable = '_myTopPrivateLevelVariable';
const myTopLevelPublicVariable = 'myTopLevelPublicVariable';

class MyPublic {
  final _myPrivateVariable = '_myPrivateVariable';
  final myPublicVariable = 'myPublicVariable';

  void _myPrivateMethod() {
    developer.log('_myPrivateMethod');
  }

  void myPublicMethod() {
    developer.log('myPublicMethod');
  }
}

class _MyPrivate {}

void main() {
  // Top-level private variables are only accessible from within the same file.
  developer.log(_myTopPrivateLevelVariable);
  developer.log(myTopLevelPublicVariable);

  final myPublic = MyPublic();
  // Private instance variables can only be accessed from the same file.
  developer.log(myPublic._myPrivateVariable);

  developer.log(myPublic.myPublicVariable);
  // Private instance methods can only be accessed from the same file.
  myPublic
    .._myPrivateMethod()
    ..myPublicMethod();

  // Private classes can only be accessed from the same file.
  final myPrivate = _MyPrivate();
  developer.log(myPrivate.toString());
}
