import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void main() => runApp(
      MaterialApp(
        home: _MyStatefulWidget(),
      ),
    );

class _MyStatefulWidget extends StatefulWidget {
  final targetDataList = _createTargetDataList(
    [
      ('Title1', 'Body1'),
      ('Title2', 'Body2'),
      ('Title3', 'Body3'),
    ],
  );

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  late TutorialCoachMark tutorialCoachMark;

  @override
  void initState() {
    super.initState();
    tutorialCoachMark = _createTutorialCoachMark(
      widget.targetDataList,
      () => tutorialCoachMark.next(),
    )..show(context: context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) => Icon(
                key: widget.targetDataList[index].$1,
                Icons.flutter_dash,
              ),
            ),
          ),
        ),
      );
}

List<(GlobalKey<State<StatefulWidget>>, String, String)> _createTargetDataList(
  List<(String, String)> titleAndBodyList,
) =>
    titleAndBodyList
        .map(
          (titleAndBody) => (
            GlobalKey<State<StatefulWidget>>(),
            titleAndBody.$1,
            titleAndBody.$2
          ),
        )
        .toList();

TutorialCoachMark _createTutorialCoachMark(
  List<(GlobalKey<State<StatefulWidget>>, String, String)> targetDataList,
  GestureTapCallback onTap,
) =>
    TutorialCoachMark(
      targets: _createTargets(targetDataList, onTap),
      paddingFocus: 0,
      hideSkip: true,
      focusAnimationDuration: Duration.zero,
      unFocusAnimationDuration: Duration.zero,
      pulseEnable: false,
    );

List<TargetFocus> _createTargets(
  List<(GlobalKey<State<StatefulWidget>>, String, String)> tutorialDataList,
  GestureTapCallback onTap,
) =>
    tutorialDataList
        .map(
          (data) => _createTarget(
            keyTarget: data.$1,
            title: data.$2,
            body: data.$3,
            onTap: onTap,
          ),
        )
        .toList();

TargetFocus _createTarget({
  required GlobalKey<State<StatefulWidget>> keyTarget,
  required String title,
  required String body,
  required GestureTapCallback onTap,
}) =>
    TargetFocus(
      keyTarget: keyTarget,
      contents: [
        TargetContent(
          child: ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: onTap,
                behavior: HitTestBehavior.translucent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            body,
                            maxLines: 10,
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_circle_right, size: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
