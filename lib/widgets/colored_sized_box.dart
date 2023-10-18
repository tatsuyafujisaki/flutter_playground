import 'package:flutter/widgets.dart';

Widget createColoreSizeddBox({
  required Color color,
  required Widget child,
  double? width,
  double? height,
}) =>
    ColoredBox(
      color: color,
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
