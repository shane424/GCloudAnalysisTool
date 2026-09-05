extends Node
signal save_started(slot: int)
signal save_finished(slot: int, success: bool)
signal load_finished(slot: int, success: bool, message: String)
const SAVE_VERSION := 2
const SLOT_COUNT := 3

func _path(slot: int) -> String: return "user://turtlehaven_slot_%d.json" % clampi(slot, 0, SLOT_COUNT - 1)
func _backup_path(slot: int) -> String: return _path(slot) + ".backup"

func save_slot(slot: int) -> bool:
	save_started.emit(slot)
	var path := _path(slot); var temp := path + ".tmp"
	var payload := {"version":SAVE_VERSION,"game":GameState.to_dict(),"accessibility":Accessibility.settings,"saved_at":Time.get_datetime_string_from_system(true)}
	var file := FileAccess.open(temp, FileAccess.WRITE)
	if file == null: save_finished.emit(slot, false); return false
	file.store_string(JSON.stringify(payload)); file.flush(); file.close()
	if FileAccess.file_exists(path):
		DirAccess.remove_absolute(_backup_path(slot)); DirAccess.rename_absolute(path, _backup_path(slot))
	var error := DirAccess.rename_absolute(temp, path)
	save_finished.emit(slot, error == OK); return error == OK

func load_slot(slot: int) -> bool:
	var result := _read_save(_path(slot))
	if not result.ok:
		result = _read_save(_backup_path(slot))
		if not result.ok: load_finished.emit(slot, false, result.message); return false
	var migrated := _migrate(result.data)
	if migrated.is_empty(): load_finished.emit(slot, false, "Incompatible save version"); return false
	GameState.load_dict(migrated.game)
	for key in migrated.get("accessibility", {}): Accessibility.set_setting(key, migrated.accessibility[key])
	Accessibility.apply(); load_finished.emit(slot, true, "Recovered backup" if result.get("backup", false) else "Loaded"); return true

func _read_save(path: String) -> Dictionary:
	if not FileAccess.file_exists(path): return {"ok":false,"message":"No save found"}
	var parsed: Variant = JSON.parse_string(FileAccess.get_file_as_string(path))
	if not parsed is Dictionary: return {"ok":false,"message":"Save data is corrupted"}
	return {"ok":true,"data":parsed,"message":""}

func _migrate(data: Dictionary) -> Dictionary:
	var version := int(data.get("version", 1))
	if version > SAVE_VERSION or version < 1: return {}
	if version == 1:
		data["accessibility"] = data.get("settings", {})
		data["version"] = 2
	return data

func delete_slot(slot: int) -> void:
	DirAccess.remove_absolute(_path(slot)); DirAccess.remove_absolute(_backup_path(slot))
