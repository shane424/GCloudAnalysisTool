# Visual asset provenance

All artwork in this repository is original to **Turtlehaven** and may be redistributed with the game under the repository license. The icon, splash, capsule mark, shell pattern, procedural coastal shapes, and procedural character rig were authored for this project on 2026-09-05. No generative or third-party visual assets are included.

## Source and export separation

Editable source artwork lives in `assets/source/` and `marketing/capsule-source/`. Runtime-ready artwork lives elsewhere under `assets/`. The hero is rendered by the original articulated vector rig in `scripts/player/turtle_controller.gd`; its distinct shell scutes, head, eyes, and four independently shaped flippers are authored geometry rather than engine placeholder primitives. NPC variant specifications are in `data/characters.json`. Before a commercial release candidate, the art director must approve final LOD exports (`hero_lod0`, `hero_lod1`, `hero_lod2`) and corresponding convex gameplay collision hulls against the asset review checklist.

No trademarks, stock textures, external fonts, or unlicensed character designs are shipped here.
