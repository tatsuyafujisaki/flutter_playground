import 'package:flutter/material.dart';

Widget _leftCenterRightWidgetStack({
  Widget? leftWidget,
  Widget? centerWidget,
  Widget? rightWidget,
}) =>
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

class _MyStatelessWidget extends StatelessWidget {
  const _MyStatelessWidget();

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _leftCenterRightWidgetStack(
              leftWidget: const FlutterLogo(),
              centerWidget: const FlutterLogo(),
            ),
            _leftCenterRightWidgetStack(
              centerWidget: const FlutterLogo(),
              rightWidget: const FlutterLogo(),
            ),
            _leftCenterRightWidgetStack(
              leftWidget: const FlutterLogo(),
              centerWidget: const FlutterLogo(),
              rightWidget: const FlutterLogo(),
            ),
          ],
        ),
      );
}

void main() => runApp(const _MyStatelessWidget());
