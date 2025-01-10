import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/packages/tutorial_coach_mark/coach_mark_target_data.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

Future<void> showTutorialOnFirstVisit(
  BuildContext context,
  List<CoachMarkTargetData> coachMarkTargetDataList,
) async {
  // const key = 'tutorial_shown';
  // final prefs = await SharedPreferences.getInstance();
  // final shown = prefs.getBool(key) ?? false;
  const shown = false;

  if (!shown && context.mounted) {
    late final TutorialCoachMark tutorialCoachMark;
    tutorialCoachMark = _createTutorialCoachMark(
      coachMarkTargetDataList,
      () => tutorialCoachMark.next(),
    )..show(context: context);
    // await prefs.setBool(key, true);
  }
}

TutorialCoachMark _createTutorialCoachMark(
  List<CoachMarkTargetData> coachMarkTargetDataList,
  GestureTapCallback onTap,
) =>
    TutorialCoachMark(
      targets: _createTargetFocusList(coachMarkTargetDataList, onTap),
      paddingFocus: 0,
      hideSkip: true,
      focusAnimationDuration: Duration.zero,
      unFocusAnimationDuration: Duration.zero,
      pulseEnable: false,
    );

List<TargetFocus> _createTargetFocusList(
  List<CoachMarkTargetData> coachMarkTargetDataList,
  GestureTapCallback onTap,
) =>
    coachMarkTargetDataList
        .map(
          (data) => _createTargetFocus(
            keyTarget: data.key,
            title: data.title,
            body: data.body,
            onTap: onTap,
            align: data.align,
          ),
        )
        .toList();

TargetFocus _createTargetFocus({
  required GlobalKey<State<StatefulWidget>> keyTarget,
  required String title,
  required String body,
  required GestureTapCallback onTap,
  ContentAlign? align,
}) =>
    TargetFocus(
      keyTarget: keyTarget,
      contents: [
        TargetContent(
          align: align ?? ContentAlign.bottom,
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
