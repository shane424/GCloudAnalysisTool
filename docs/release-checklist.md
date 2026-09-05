# Release gate

A release candidate exists only when **every** item below and every item in `qa-checklist.md` is evidenced and passed. Current repository status is a production foundation, not a release candidate.

- [ ] Campaign is playable from clean launch through credits and persistent post-game on Windows and Linux.
- [ ] Three repeated full playthroughs per platform have no blocker or editor-only dependency.
- [ ] All temporary/placeholder assets are removed; art, rig, LOD, animation, audio, localization, and UI reviews pass.
- [ ] Windows and Linux exports launch on clean machines without Godot installed and meet signed build checks.
- [ ] Controller-only and keyboard/mouse-only campaigns pass, including every menu.
- [ ] Save atomicity, backup recovery, migrations, corruption handling, multiple slots, and suspend/resume pass.
- [ ] Automated contracts and scene smoke tests pass from a clean checkout.
- [ ] Performance budgets pass on minimum and recommended hardware for all quality presets.
- [ ] Attribution and commercial redistribution records cover every shipped asset and dependency.
- [ ] Store materials, content disclosure, credits, privacy, support, build instructions, and third-party notices are final.
- [ ] Steamworks remains optional and no ungranted Steam Deck verification claim appears.
