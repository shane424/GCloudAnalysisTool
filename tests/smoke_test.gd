extends SceneTree
var failures: Array[String] = []
func _initialize() -> void:
	for path in _find_scenes("res://scenes"):
		var packed := load(path) as PackedScene
		if packed == null: failures.append("Cannot load " + path); continue
		var instance := packed.instantiate()
		if instance == null: failures.append("Cannot instantiate " + path)
		else: instance.free()
	print("Scene smoke test: %d failure(s)" % failures.size())
	for failure in failures: push_error(failure)
	quit(1 if failures else 0)
func _find_scenes(path: String) -> Array[String]:
	var found: Array[String] = []; var dir := DirAccess.open(path)
	if dir == null: return found
	dir.list_dir_begin()
	var name := dir.get_next()
	while name:
		var full := path.path_join(name)
		if dir.current_is_dir(): found.append_array(_find_scenes(full))
		elif name.ends_with(".tscn"): found.append(full)
		name = dir.get_next()
	return found
