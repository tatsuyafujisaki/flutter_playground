---
trigger: always_on
---

- Follow these best practices unless otherwise specified. In the event of a conflict, the source listed higher in the hierarchy takes precedence.
  - https://docs.flutter.dev/app-architecture/recommendations
  - https://developers.google.com/style
- After making any changes, run
  `dart fix --apply && dart format . && flutter analyze` and fix all analysis issues.
