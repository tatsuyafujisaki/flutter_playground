import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_playground/extension/extensions.dart';
import 'package:flutter_playground/widgets/packages/tutorial_coach_mark/tutorial_coach_mark_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

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
  final coachMarkKey1 = GlobalKey();
  final coachMarkKey2 = GlobalKey();

  List<(GlobalKey<State<StatefulWidget>>, String, String)>
      get keyAndTitleAndBodyList => <(GlobalKey, String, String)>[
            (
              coachMarkKey1,
              context.l10n.coachMark1Title,
              context.l10n.coachMark1Body,
            ),
            (
              coachMarkKey2,
              context.l10n.coachMark2Title,
              context.l10n.coachMark2Body,
            ),
          ];

  @override
  void initState() {
    super.initState();
    unawaited(_showTutorialOnFirstVisit());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                key: coachMarkKey1,
                Icons.flutter_dash,
              ),
              Icon(
                key: coachMarkKey2,
                Icons.flutter_dash,
              ),
            ],
          ),
        ),
      );

  Future<void> _showTutorialOnFirstVisit() async {
    const key = 'tutorial_shown';
    final prefs = await SharedPreferences.getInstance();
    final shown = prefs.getBool(key) ?? false;

    if (!shown && mounted) {
      late final TutorialCoachMark tutorialCoachMark;
      tutorialCoachMark = createTutorialCoachMark(
        keyAndTitleAndBodyList,
        () => tutorialCoachMark.next(),
      )..show(context: context);
      await prefs.setBool(key, true);
    }
  }
}
