import 'package:flutter/widgets.dart';

bool isDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;
