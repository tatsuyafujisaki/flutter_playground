import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'riverpod_examples.g.dart';

final myBoolStateProvider = StateProvider.autoDispose((_) => false);

@riverpod
bool myGeneratedBool(MyGeneratedBoolRef ref) => false;

/// https://docs-v2.riverpod.dev/docs/providers/state_provider#how-to-update-the-state-based-on-the-previous-value-without-reading-the-provider-twice
void updateStateExample(WidgetRef ref) {
  ref.read(myBoolStateProvider.notifier).update((state) => !state);
}
