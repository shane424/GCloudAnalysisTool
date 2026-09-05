# Manual QA checklist

Record build hash, OS/GPU/controller, tester, date, result, defect link, and evidence for every run. A checked box without evidence is not a release pass.

## Clean install and campaign
- [ ] Install each Windows/Linux package on a machine without Godot; launch offline from a non-admin account.
- [ ] Start each of three empty save slots; finish from opening through playable credits with no editor, console, or debug shortcut.
- [ ] Confirm a 3–5 hour first playthrough, deterministic shell balance, all critical gates, satisfying finale, and persistent explorable post-game.
- [ ] Complete every rescue, debris clear, reef garden, current route, light puzzle, shell mechanism, tide path, observation, memory, and time trial.
- [ ] Verify failure always has a clear nearby recovery route and optional timers never block story progress.
- [ ] Confirm ecological stages transform terrain, clarity, plants, wildlife, audio, and NPC behavior and remain restored after travel/load.
- [ ] Watch all hub-dialogue stages, personal quests, short scenes, ending, and credits; check every supported locale for overflow and hard-coded text.

## Input and accessibility
- [ ] Controller-only completion: launch, all gameplay, all screens, OS focus loss, credits, quit; reconnect during play and test two common controller families.
- [ ] Keyboard/mouse-only completion with the same coverage; validate simultaneous-device switching.
- [ ] Rebind every action, reject conflicts clearly, restore defaults, restart, and confirm persistence.
- [ ] Validate hold/toggle dive, camera sensitivity, vibration off/levels, unstuck, navigation/puzzle/timing/damage assists.
- [ ] Validate UI scaling and every subtitle size/background at 1280×720 through 4K; no clipped focus or unreadable prompt.
- [ ] Validate high contrast, color-safe shapes without color reliance, reduced flashing during storm/finale, and reduced camera/foliage/particle motion.
- [ ] Validate master/music/ambience/SFX categories independently, including zero volume.
- [ ] Traverse every objective using text, landmarks, environmental sound, and journal—never relying solely on arrows.

## Display, performance, and lifecycle
- [ ] Exercise windowed/fullscreen and resolution changes at 720p, 1080p, 1440p, ultrawide, and 4K; unplug/replug a display.
- [ ] Run Low/Medium/High on minimum/recommended hardware; capture CPU/GPU frame time, draw calls, resident memory, and cold load times against design budgets.
- [ ] Inspect LOD transitions, collision hulls, material/texture residency, particles, AI throttling, streaming, shaders, waterline, shadows, and interactable contrast.
- [ ] Suspend/resume, sleep/wake, focus loss, controller disconnect, forced process termination, and 50 location transitions without state loss.
- [ ] Run at least three full soak playthroughs per platform and one six-hour post-game roam.

## Persistence and recovery
- [ ] Verify manual/autosave indicator, three-slot isolation, settings and accessibility persistence, atomic write, and backup rotation.
- [ ] Interrupt a save at each write/rename boundary; corrupt/truncate primary and recover backup with a plain-language message.
- [ ] Load supported older schema fixtures; reject newer incompatible saves gracefully and preserve them.
- [ ] Validate campaign progress, health, collectibles, upgrades, settings, accessibility, play time, and post-game round trips.
- [ ] Uninstall/reinstall behavior matches platform expectations; deletion is deliberate and confirmed.

## Commercial release audit
- [ ] Search the package for TODO, debug UI, placeholder art/audio, absolute paths, secrets, dev certificates, and editor-only resources.
- [ ] Art/audio/dependency license ledger is complete and redistribution proof archived; third-party notices match shipped content.
- [ ] Icons, capsules, screenshots, trailer, store copy, disclosures, privacy, credits, and support links match the final build.
- [ ] Steam Input actions are usable while Steamworks is absent; direct build remains fully offline.
- [ ] Do not display or claim Steam Deck Verified unless Valve has granted it.
