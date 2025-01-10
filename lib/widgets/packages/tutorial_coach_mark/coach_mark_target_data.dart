import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

part 'coach_mark_target_data.freezed.dart';

@freezed
class CoachMarkTargetData with _$CoachMarkTargetData {
  const factory CoachMarkTargetData({
    required GlobalKey<State<StatefulWidget>> key,
    required String title,
    required String body,
    ContentAlign? align,
  }) = _CoachMarkTargetData;
}
