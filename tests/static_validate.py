#!/usr/bin/env python3
"""Dependency and deterministic-content checks runnable without Godot."""
import json, re, sys
from pathlib import Path
ROOT = Path(__file__).parents[1]
errors=[]
# Keep the repository patch text-only for review systems that reject binary diffs.
text_extensions={".md",".gd",".tscn",".tres",".godot",".cfg",".json",".po",".svg",".gdshader",".py",".gitignore"}
for candidate in ROOT.rglob("*"):
    if candidate.is_file() and candidate.suffix != ".import" and not any(part in {".git", ".godot", "build"} for part in candidate.parts) and candidate.suffix not in text_extensions and candidate.name not in {"README", ".godot-version", ".gitignore"}:
        errors.append(f"unsupported binary or unclassified artifact {candidate.relative_to(ROOT)}")
required=["project.godot","export_presets.cfg","docs/game-design.md","assets/ATTRIBUTION.md","audio/ATTRIBUTION.md","data/islands/campaign.json"]
for item in required:
    if not (ROOT/item).is_file(): errors.append(f"missing {item}")
project=(ROOT/"project.godot").read_text()
for path in re.findall(r'"(res://[^"\n]+)"',project):
    if path.endswith((".gd",".tscn",".svg",".po")) and not (ROOT/path[6:]).exists(): errors.append(f"broken project dependency {path}")
campaign=json.loads((ROOT/"data/islands/campaign.json").read_text())
if len(campaign["islands"]) < 5: errors.append("campaign requires hub, three islands, finale")
if campaign["resource_total"] < campaign["upgrade_cost_total"]: errors.append("campaign economy requires grinding")
for scene in (ROOT/"scenes").rglob("*.tscn"):
    for path in re.findall(r'path="res://([^\"]+)"',scene.read_text()):
        if not (ROOT/path).exists(): errors.append(f"{scene.relative_to(ROOT)} -> missing {path}")
if errors:
    print("FAIL\n"+"\n".join(errors)); sys.exit(1)
print(f"PASS: {len(list((ROOT/'scenes').rglob('*.tscn')))} scenes; deterministic campaign surplus {campaign['resource_total']-campaign['upgrade_cost_total']} shells")
