import 'package:flutter/material.dart';

Color? getMaterialColor(MaterialColor materialColor, int index) {
  final i = index % 9;
  final value = i == 0 ? 50 : 100 * i;
  return materialColor[value];
}
