import 'package:flutter/material.dart';

void main() => runApp(_createApp());

Widget _createApp({
  Color color = Colors.cyan,
  double? width = double.infinity,
  double? height,
  Widget? child,
}) =>
    ColoredBox(
      color: color,
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
