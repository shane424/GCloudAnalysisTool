class_name IsometricCamera
extends Camera2D
@export var follow_smoothing := 6.0
@export var min_zoom := 0.72
@export var max_zoom := 1.35
var target: Node2D
var framing_offset := Vector2.ZERO

func _ready() -> void:
	position_smoothing_enabled = true; position_smoothing_speed = follow_smoothing
	target = get_tree().get_first_node_in_group("player") as Node2D

func _process(delta: float) -> void:
	if not is_instance_valid(target): target = get_tree().get_first_node_in_group("player") as Node2D
	if target:
		var motion_scale := 0.25 if Accessibility.get_setting("reduced_motion", false) else 1.0
		global_position = target.global_position + framing_offset * motion_scale
	var zoom_step: float = float(Input.get_axis("zoom_out", "zoom_in")) * delta * Accessibility.get_setting("camera_sensitivity", 1.0)
	var value := clampf(zoom.x + zoom_step, min_zoom, max_zoom); zoom = Vector2.ONE * value
