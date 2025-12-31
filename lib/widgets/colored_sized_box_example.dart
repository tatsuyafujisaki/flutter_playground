import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(ProviderScope(child: _createApp()));

Widget _createApp({
  Color color = Colors.cyan,
  double? width = double.infinity,
  double? height,
  Widget? child,
}) => ColoredBox(
  color: color,
  child: SizedBox(width: width, height: height, child: child),
);
