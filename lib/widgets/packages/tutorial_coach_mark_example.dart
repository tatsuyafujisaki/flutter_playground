import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void main() => runApp(
      MaterialApp(
        home: _MyStatefulWidget(),
      ),
    );

class _MyStatefulWidget extends StatefulWidget {
  final keys = List.generate(3, (_) => GlobalKey());

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<_MyStatefulWidget> {
  late TutorialCoachMark tutorialCoachMark;

  @override
  void initState() {
    super.initState();
    tutorialCoachMark = TutorialCoachMark(
      targets: createTargets(),
      hideSkip: true,
      focusAnimationDuration: Duration.zero,
      unFocusAnimationDuration: Duration.zero,
      pulseEnable: false,
    );
    tutorialCoachMark.show(context: context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) => Icon(key: widget.keys[index], Icons.flutter_dash),
            ),
          ),
        ),
      );

  List<TargetFocus> createTargets() => List<TargetFocus>.generate(
        3,
        (index) => TargetFocus(
          keyTarget: widget.keys[index],
          contents: [
            TargetContent(
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () => tutorialCoachMark.next(),
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ルームの作成・参加',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'ルームの作成・参加ができます。\n作成にはマネージャー以上の権限が必要です。',
                                maxLines: 10,
                                style: TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_circle_right, size: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
