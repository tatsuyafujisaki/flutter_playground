import 'package:flutter/widgets.dart';

Widget createColoreSizedBox({
  Color color = Colors.pink,
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
