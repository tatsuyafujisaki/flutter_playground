import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_generator_examples.g.dart';

// Generates AutoDisposeProvider<bool>
@riverpod
String myGeneratedParameterless(Ref ref) => 'Hello!';

@riverpod
String myGeneratedRequiredParameter(Ref ref, String name) => 'Hello, $name!';

@riverpod
String myGeneratedOptionalParameter(Ref ref, [String name = 'Anonymous']) =>
    'Hello, $name!';

@riverpod
String myGeneratedRequiredParameters(Ref ref, String name, int age) =>
    'Hello, $age-year-old $name!';

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
  @override
  Set<String> build() => {};

  void add(String s) {
    state = {...state, s};
  }

  void remove(String s) {
    state.remove(s);
  }
}

void showGeneratedFunctionProviderExamples() {
  final container = ProviderContainer();
  print(container.read(myGeneratedParameterlessProvider)); // Hello!
  print(
    container.read(myGeneratedRequiredParameterProvider('Minnie')),
  ); // Hello, Minnie!
  print(
    container.read(myGeneratedOptionalParameterProvider()),
  ); // Hello, Anonymous!
  print(
    container.read(myGeneratedOptionalParameterProvider('Donald')),
  ); // Hello, Donald!

  print(
    container.read(myGeneratedRequiredParametersProvider('Goofy', 18)),
  ); // Hello, Donald!
}

void showGeneratedBoolNotifirerProviderExamples() {
  final container = ProviderContainer();
  print(container.read(myBoolProvider)); // false
  container.read(myBoolProvider.notifier).toggle();
  print(container.read(myBoolProvider)); // true
}

void showGeneratedSetNotifirerProviderExamples() {
  final container = ProviderContainer();
  print(container.read(mySetProvider)); // {}
  container.read(mySetProvider.notifier).add('a');
  print(container.read(mySetProvider)); // {'a'}
  container.read(mySetProvider.notifier).add('b');
  container.read(mySetProvider.notifier).remove('a');
  print(container.read(mySetProvider)); // {'b'}
}
