extends CanvasLayer
signal transition_started
signal transition_finished
var curtain: ColorRect
var busy := false

func _ready() -> void:
	layer = 100
	curtain = ColorRect.new(); curtain.color = Color("#062d38"); curtain.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT); curtain.mouse_filter = Control.MOUSE_FILTER_IGNORE; curtain.modulate.a = 0.0; add_child(curtain)

func change_scene(path: String) -> bool:
	if busy or not ResourceLoader.exists(path): return false
	busy = true; transition_started.emit(); curtain.mouse_filter = Control.MOUSE_FILTER_STOP
	await create_tween().tween_property(curtain, "modulate:a", 1.0, 0.25).finished
	var error := get_tree().change_scene_to_file(path)
	await get_tree().process_frame
	await create_tween().tween_property(curtain, "modulate:a", 0.0, 0.35).finished
	curtain.mouse_filter = Control.MOUSE_FILTER_IGNORE; busy = false; transition_finished.emit()
	return error == OK
