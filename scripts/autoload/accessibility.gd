extends Node
signal settings_changed
var settings := {"subtitle_scale":1.0,"ui_scale":1.0,"high_contrast":false,"color_safe":true,"reduced_motion":false,"reduced_flashing":true,"camera_sensitivity":1.0,"camera_shake":1.0,"vibration":1.0,"hold_to_dive":true,"assist_strength":0,"master_volume":0.8,"music_volume":0.75,"ambience_volume":0.8,"sfx_volume":0.85,"graphics_preset":1}

func set_setting(key: String, value: Variant) -> void:
	if not settings.has(key): return
	settings[key] = value
	settings_changed.emit()

func get_setting(key: String, fallback: Variant = null) -> Variant:
	return settings.get(key, fallback)

func apply() -> void:
	get_tree().root.content_scale_factor = float(settings.ui_scale)
	for bus_name in ["Master", "Music", "Ambience", "SFX"]:
		var index := AudioServer.get_bus_index(bus_name)
		if index >= 0:
			var key: String = str(bus_name).to_lower() + "_volume"
			AudioServer.set_bus_volume_db(index, linear_to_db(float(settings.get(key, 1.0))))
