# Changelog entries

Every PR adds one file here: `<PR number>.<type>.md`, containing one sentence.

Easiest: double-click `new-change.bat` in the repo root.
Or on GitHub: open your PR, then Add file → `changelog.d/123.fixed.md`.

Types: added, changed, deprecated, removed, fixed, security

Examples:
- `123.fixed.md` → Conveyor FB_Motor no longer faults when restarting after E-stop.
- `124.added.md` → New FB_ValveControl with position feedback.
- `125.changed.md` → Tank overfill alarm text now includes the tank number.

Write what changed on the machine or in the project, not how the code changed.
No entry needed? Ask a reviewer to add the `no-changelog` label.
