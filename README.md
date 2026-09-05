# Turtlehaven

A controller-first, single-player isometric environmental adventure made with Godot. Restore a supernatural-storm-damaged archipelago as Naru, a young sea turtle. See [`docs/game-design.md`](docs/game-design.md) for the product specification.

## Editor setup

Turtlehaven pins **Godot 4.3.0 stable** in `.godot-version` and declares the `4.3` feature set. Install the standard Godot editor (not .NET), open this repository's `project.godot`, allow imports to finish, and run the project with F6/F5. No add-ons, online SDK, credentials, or absolute paths are required. The GL Compatibility renderer provides the lower-end baseline.

For exports, install matching Godot 4.3 export templates through **Editor → Manage Export Templates**. Open **Project → Export**, select Windows Desktop or Linux, and export. CLI equivalents:

```bash
godot --headless --path . --import
godot --headless --path . --export-release "Windows Desktop" build/windows/Turtlehaven.exe
godot --headless --path . --export-release "Linux" build/linux/Turtlehaven.x86_64
```

Test each resulting executable on a clean machine without Godot installed. Source art and tests are excluded from builds; runtime assets and attribution remain included. Steamworks is an optional adapter, so itch.io, direct, and offline Steam builds use the same core executable.

## Repository layout

* `scenes/` gameplay, activity, character, and UI scenes
* `scripts/` runtime systems and optional platform integration
* `assets/` engine-ready art plus separate editable sources
* `audio/` commercially reviewed music, ambience, and effects
* `shaders/` scalable water, foliage, wet-sand, caustic, and grade effects
* `data/` deterministic campaign content and external translations
* `tests/` automated headless validation
* `docs/` design, QA, release, privacy, and support material
* `marketing/` store copy and editable promotional sources

## Validation

```bash
python3 tests/static_validate.py
godot --headless --path . --quit-after 10
godot --headless --path . -s tests/smoke_test.gd
```

A release is not complete until every item in `docs/release-checklist.md` and `docs/qa-checklist.md` passes on clean Windows and Linux machines.
