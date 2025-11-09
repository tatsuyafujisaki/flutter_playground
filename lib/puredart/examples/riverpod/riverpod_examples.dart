import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_examples.g.dart';

@riverpod
String myGeneratedOptionalParameter(Ref ref, [String name = 'Anonymous']) =>
    'Hello, $name!';

// Generates AutoDisposeProvider<bool>
@riverpod
String myGeneratedParameterless(Ref ref) => 'Hello!';

@riverpod
String myGeneratedRequiredParameter(Ref ref, String name) => 'Hello, $name!';

@riverpod
String myGeneratedRequiredParameters(Ref ref, String name, int age) =>
    'Hello, $age-year-old $name!';

void showGeneratedBoolNotifirerProviderExamples() {
  final container = ProviderContainer();
  debugPrint(container.read(myBoolProvider).toString()); // false
  container.read(myBoolProvider.notifier).toggle();
  debugPrint(container.read(myBoolProvider).toString()); // true
}

void showGeneratedFunctionProviderExamples() {
  final container = ProviderContainer();
  debugPrint(container.read(myGeneratedParameterlessProvider)); // Hello!
  debugPrint(
    container.read(myGeneratedRequiredParameterProvider('Minnie')),
  ); // Hello, Minnie!
  debugPrint(
    container.read(myGeneratedOptionalParameterProvider()),
  ); // Hello, Anonymous!
  debugPrint(
    container.read(myGeneratedOptionalParameterProvider('Donald')),
  ); // Hello, Donald!

  debugPrint(
    container.read(myGeneratedRequiredParametersProvider('Goofy', 18)),
  ); // Hello, Donald!
}

void showGeneratedSetNotifirerProviderExamples() {
  final container = ProviderContainer();
  debugPrint(container.read(mySetProvider).toString()); // {}
  container.read(mySetProvider.notifier).add('a');
  debugPrint(container.read(mySetProvider).toString()); // {'a'}
  container.read(mySetProvider.notifier).add('b');
  container.read(mySetProvider.notifier).remove('a');
  debugPrint(container.read(mySetProvider).toString()); // {'b'}
}

// Generates AutoDisposeNotifierProviderImpl<MyBool, bool>
@riverpod
class MyBool extends _$MyBool {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }
}

@riverpod
class MySet extends _$MySet {
  void add(String s) {
    state = {...state, s};
  }

  @override
  Set<String> build() => {};

  void remove(String s) {
    state.remove(s);
  }
}
