import 'package:flutter/material.dart';

Future<void> showModalBottomSheetExample<T>(
  BuildContext context,
  Widget child,
) =>
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => child,
      useSafeArea: true,
    );
