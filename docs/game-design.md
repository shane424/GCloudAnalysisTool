# Turtlehaven — game design

## Product definition

**Turtlehaven** is a premium, single-player environmental adventure for Windows and Linux. A supernatural storm has shattered an ancient migration route. As Naru, a young green sea turtle, the player restores a small archipelago, rescues wildlife, heals coral, solves environmental mechanisms, and rebuilds Moonpool Haven. The complete, focused campaign targets **3–5 hours** and a **USD $5–10** Steam price. It has no microtransactions, advertisements, required account, telemetry, or online-service dependency.

The presentation is a three-quarter isometric coastal diorama with controller-first actions and equally complete keyboard/mouse support. Warm restoration—not punishment or extraction—is the fantasy. Failure returns the player to a nearby safe eddy with progress intact.

## Core loop and progression

1. Read environmental clues and follow wildlife, sound, currents, landmarks, and journal sketches.
2. Traverse by crawling, swimming, diving, gliding on currents, and opening tide routes.
3. Complete a handcrafted rescue, debris, reef-gardening, observation, or environmental puzzle.
4. Receive a fixed, one-time restoration-shell award; see island health transform immediately.
5. Return to Moonpool Haven, hear evolving character dialogue, and buy a deterministic upgrade.
6. Use the new verb on the next island, then encounter a remix of old and new verbs.

Each island has five ecological health bands: storm-scarred, stabilizing, returning, thriving, and restored. Health changes water clarity, foam, vegetation density, coral color, wildlife schools, ambience stems, and NPC schedules. Thirty campaign shells fund seventeen shells of required/cosmetic upgrades, leaving a generous discovery buffer; no renewable task or grind is needed. Island gates use prior-island health (65%), while the ending requires all critical route beacons, not optional time trials.

Upgrades: **Deep Dive** opens trenches; **Current Glide** allows safe current riding; **Reef Song** activates living light relays; **Shell Markings** are cosmetic. Story scenes follow sanctuary tiers. Post-game preserves every restored location and unlocks free travel, memory replay, and optional best-time runs.

## Campaign and content scope

| Location | Identity | New focus | Story beat |
|---|---|---|---|
| Moonpool Haven | Sheltered turquoise sanctuary and pale stone arches | upgrading, dialogue, reef gardening | Naru, Mara, and Pip establish a rescue home |
| Driftwood Cay | Wind-carved dunes, wreckwood, tide pools | tide paths, carries, shell-pattern locks | Sela faces the wreck she could not save |
| Lumen Reef | Deep blue terraces and bioluminescent coral | depth, current lanes, light routing | Oru returns to gardening after injury |
| Whisperroot Isles | Amber mudflats and dense mangrove waterways | observation and reflected root patterns | hatchlings reveal a forgotten route marker |
| The Tempest Eye | Moonlit ruins inside the supernatural storm | confident remixes and route alignment | the group calms the storm and restores migration |

Content budget: five compact locations; 12 critical activities; 6 optional migration memories; 3 optional time trials; 5 named turtles; about 5,500 localized words; 8 short in-engine scenes; one finale and post-game conversation set. The narrative uses staged gameplay cameras and animation rather than pre-rendered cinematics.

## Handcrafted activity grammar

* **Current channels:** enter on a readable pulse, steer between eddies, and exit anywhere safe; assist mode widens gates.
* **Reef light:** rotate living coral to pass color-and-shape-coded light; never rely on hue alone.
* **Shell mechanisms:** copy scute patterns found in architecture or NPC markings, with journal hints after two attempts.
* **Tide paths:** waterlines and shorebirds telegraph the cycle; missing a tide opens a short alternate wait activity.
* **Rescues:** observe the animal, remove hazards in an order, then escort or carry without health-loss fail states.
* **Observation:** infer nesting, feeding, or current behavior from multiple visual, sound, and journal cues.
* **Migration memories/time trials:** optional lore and mastery; all narrative and completion rewards remain untimed.

## Traversal and controls

Movement is analog and camera-relative with acceleration/deceleration, forgiving capsule collision, slope alignment, buffered interaction, last-safe-position unstuck, and contextual land/water speed. Normal travel consumes no stamina; only sprint-swim does, creating route decisions. Currents add a readable vector. Dive may be hold or toggle. Transitions blend buoyancy, bank, flipper cadence, body height, wetness, and shore audio.

| Action | Keyboard/mouse | Common controller |
|---|---|---|
| Move | WASD | left stick |
| Interact / confirm | E | south face button |
| Dive / back | Space | east face button |
| Sprint-swim | Shift | right trigger |
| Journal/map | J | north face button |
| Pause | Escape | Menu |
| Zoom | wheel | stick clicks |

All actions are remappable. Camera sensitivity, vibration strength, reduced motion, hold/toggle, and an emergency unstuck command are exposed. Menus use focus neighbors, visible focus, mouse hit targets, and standard confirm/back semantics.

## Character and animation direction

Naru has a heart-shaped golden-green scute pattern, soft organic silhouette, large readable eyes, and long articulated front flippers. Mara (hawksbill), Pip (hatchling), Oru (injured leatherback), and Sela (loggerhead) differ in species proportions, shell edge, scale, posture, and movement timing—not palette alone. Text and acting convey voices without recorded dialogue.

Required clips: idle, crawl, swim, sprint-swim, turn, dive, surface, interact, push, rest, celebrate, damage, recover, plus curious, worried, relieved, determined, and playful reactions. A state-machine blend tree crossfades locomotion; procedural roll banks into turns, flippers adapt to speed/current, a ground probe aligns the body to terrain, and a transition blend handles waterline buoyancy. Runtime targets are LOD0 18–24k triangles, LOD1 8–12k, LOD2 2–4k; one simplified convex movement hull and separate interaction area.

## Visual and audio direction

Shapes are rounded and wind/water-eroded: curved shore splines, terraced sand/soil/rock, hand-authored reefs, bent vegetation, driftwood, ruins, and sanctuary arches. Shipping terrain must never be blockout cubes or raw placeholder primitives. A clear value hierarchy keeps the player and interactables outlined by local contrast and rim light while preserving depth, fog, shadow, and occlusion.

Water layers combine depth gradient, scrolling normals, shore foam, reef caustics, wet-sand bands, particles, and gentle reflections. Foliage bends in coherent gusts. Restoration shifts the grade from gray-green to turquoise/coral, adds wildlife and detail, and opens higher musical layers. Reduced flashing replaces lightning; reduced motion damps camera/foliage/particles.

Audio has shoreline, underwater, weather, wildlife, sanctuary, and island-specific beds; surface/material movement; flipper, shell, splash, debris, foliage, puzzle, UI, and transformation cues; and adaptive exploration, danger, restoration, and finale music stems. Commercial provenance is mandatory.

## UI and accessibility

Shell arcs, tide lines, sea-glass panels, warm sand type, and high-contrast teal focus rings unify the main menu, HUD, journal, island map, upgrades, pause/settings, credits, and three save slots. Objectives provide a sentence, illustration/landmark, environmental signal, and optional map hint—never waypoint-only guidance.

UI scale, subtitle size/background, high-contrast interaction icons, color-vision-safe shape cues, reduced flashing/motion, independent master/music/ambience/SFX volumes, vibration, remapping, hold/toggle, camera sensitivity, puzzle hints, wider timing, navigation assist, and no-damage recovery are supported. All essential information is readable at 1280×720 and 200% UI.

## Performance tiers and hardware

Targets: 60 fps recommended and stable 30 fps minimum; CPU frame 12 ms, GPU 14 ms at recommended; fewer than 900 visible draw calls; under 2.5 GB resident memory; under 8 seconds cold location load from SSD and 15 seconds from HDD. Low reduces particles, foliage instances, water reflection resolution, shadow distance, and texture cap. Medium is default. High adds denser vegetation, higher water/caustic resolution, longer shadows, and more wildlife—never gameplay information.

**Minimum (720p/30 Low):** Windows 10 64-bit or a current 64-bit Linux distribution; Intel Core i3-6100 / AMD FX-6300; 8 GB RAM; Intel UHD 620 or Vulkan/OpenGL 3.3-capable GPU with 2 GB shared/dedicated memory; 3 GB storage; keyboard/mouse or XInput-compatible controller.

**Recommended (1080p/60 High):** Windows 11 64-bit or current 64-bit Linux; Intel Core i5-8400 / Ryzen 5 2600; 16 GB RAM; GTX 1050 Ti / RX 570-class GPU with 4 GB VRAM; SSD; common Xbox, PlayStation, or SDL-compatible controller.
