import 'package:flutter/material.dart';

import '../../../extension/extensions.dart';
import '../../../l10n/app_localizations.dart';
import 'coach_mark_target_data.dart';
import 'tutorial_coach_mark_utils.dart';

void main() => runApp(
  MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: _MyStatefulWidget(),
  ),
);

class _MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  final key1 = GlobalKey();
  final key2 = GlobalKey();

  List<CoachMarkTargetData> get keyAndTitleAndBodyList => <CoachMarkTargetData>[
    CoachMarkTargetData(
      key: key1,
      title: context.l10n.coachMarkTitle1,
      body: context.l10n.coachMarkBody1,
    ),
    CoachMarkTargetData(
      key: key2,
      title: context.l10n.coachMarkTitle2,
      body: context.l10n.coachMarkBody2,
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(key: key1, Icons.flutter_dash),
          Icon(key: key2, Icons.flutter_dash),
        ],
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => showTutorialOnFirstVisit(context, keyAndTitleAndBodyList),
    );
  }
}
