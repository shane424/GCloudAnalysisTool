class_name SteamAdapter
extends RefCounted
## Optional boundary: core game never depends on Steamworks or network availability.
func is_available() -> bool: return false
func set_rich_presence(_location: String) -> void: pass
func unlock_achievement(_id: String) -> void: pass
