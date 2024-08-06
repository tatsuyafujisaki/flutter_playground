import 'package:flutter/material.dart';

Widget leftCenterRightWidgetStack(
  Widget? leftWidget,
  Widget? centerWidget,
  Widget? rightWidget,
) =>
    Stack(
      alignment: Alignment.center,
      children: <Widget>[
        if (leftWidget != null)
          Align(
            alignment: Alignment.centerLeft,
            child: leftWidget,
          ),
        if (centerWidget != null) centerWidget,
        if (rightWidget != null)
          Align(
            alignment: Alignment.centerRight,
            child: rightWidget,
          ),
      ],
    );
