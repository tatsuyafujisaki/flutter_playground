import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

TutorialCoachMark createTutorialCoachMark(
  List<(GlobalKey<State<StatefulWidget>>, String, String)>
      keyAndTitleAndBodyList,
  GestureTapCallback onTap,
) =>
    TutorialCoachMark(
      targets: _createTargetFocusList(keyAndTitleAndBodyList, onTap),
      paddingFocus: 0,
      hideSkip: true,
      focusAnimationDuration: Duration.zero,
      unFocusAnimationDuration: Duration.zero,
      pulseEnable: false,
    );

List<TargetFocus> _createTargetFocusList(
  List<(GlobalKey<State<StatefulWidget>>, String, String)> tutorialDataList,
  GestureTapCallback onTap,
) =>
    tutorialDataList
        .map(
          (data) => _createTargetFocus(
            keyTarget: data.$1,
            title: data.$2,
            body: data.$3,
            onTap: onTap,
          ),
        )
        .toList();

TargetFocus _createTargetFocus({
  required GlobalKey<State<StatefulWidget>> keyTarget,
  required String title,
  required String body,
  required GestureTapCallback onTap,
}) =>
    TargetFocus(
      keyTarget: keyTarget,
      contents: [
        TargetContent(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
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
                      const Icon(Icons.arrow_circle_right, size: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
