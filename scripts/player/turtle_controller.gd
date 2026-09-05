class_name TurtleController
extends CharacterBody2D
## Controller-first traversal with buffering, forgiving collision, currents, and land/water blending.
signal interacted
@export var swim_speed := 260.0
@export var land_speed := 145.0
@export var acceleration := 900.0
@export var deceleration := 1100.0
var in_water := true
var diving := false
var stamina := 1.0
var current_force := Vector2.ZERO
var last_safe_position := Vector2.ZERO
var input_buffer := 0.0
var facing := Vector2.RIGHT
var bank := 0.0

func _ready() -> void:
	last_safe_position = global_position
	add_to_group("player")
	queue_redraw()

func _physics_process(delta: float) -> void:
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# Isometric camera-relative basis: screen vertical contributes equally to world axes.
	var direction := Vector2(input.x + input.y, (input.y - input.x) * 0.52).normalized()
	var speed := swim_speed if in_water else land_speed
	var sprinting := Input.is_action_pressed("sprint") and in_water and stamina > 0.08
	if sprinting: speed *= 1.35; stamina = maxf(0.0, stamina - delta * 0.22)
	else: stamina = minf(1.0, stamina + delta * 0.35)
	var target := direction * speed + current_force
	velocity = velocity.move_toward(target, (acceleration if direction else deceleration) * delta)
	if direction:
		facing = direction; bank = lerpf(bank, clampf(direction.x * 0.16, -0.16, 0.16), delta * 7.0)
	else: bank = lerpf(bank, 0.0, delta * 5.0)
	rotation = bank
	move_and_slide()
	if get_slide_collision_count() == 0: last_safe_position = global_position
	if Input.is_action_just_pressed("interact"): input_buffer = 0.18
	input_buffer = maxf(0.0, input_buffer - delta)
	if input_buffer > 0.0:
		interacted.emit(); input_buffer = 0.0
	if Accessibility.get_setting("hold_to_dive", true): diving = Input.is_action_pressed("dive")
	elif Input.is_action_just_pressed("dive"): diving = not diving
	if global_position.length() > 2500.0: recover_unstuck()
	queue_redraw()

func recover_unstuck() -> void:
	global_position = last_safe_position; velocity = Vector2.ZERO

func _draw() -> void:
	# Original layered vector rig: organic shell, articulated flippers, expressive face.
	var bob := sin(Time.get_ticks_msec() * 0.004) * 2.0
	draw_set_transform(Vector2(0, bob), facing.angle(), Vector2.ONE)
	var stroke := Color("#102f35")
	draw_colored_polygon(PackedVector2Array([Vector2(-22,-7),Vector2(-50,-27),Vector2(-57,-17),Vector2(-35,5)]), Color("#52a990"))
	draw_colored_polygon(PackedVector2Array([Vector2(-22,7),Vector2(-48,30),Vector2(-58,21),Vector2(-34,-2)]), Color("#3f927f"))
	draw_colored_polygon(PackedVector2Array([Vector2(18,-8),Vector2(48,-27),Vector2(55,-16),Vector2(32,5)]), Color("#5cb59a"))
	draw_colored_polygon(PackedVector2Array([Vector2(18,8),Vector2(45,29),Vector2(55,19),Vector2(31,-4)]), Color("#428f7c"))
	draw_circle(Vector2.ZERO, 31, stroke); draw_circle(Vector2.ZERO, 27, Color("#dbad54"))
	for p in [Vector2(-12,-10),Vector2(10,-11),Vector2(-14,10),Vector2(9,10),Vector2(0,0)]: draw_circle(p, 7, Color("#517b55"))
	draw_circle(Vector2(34,0), 15, Color("#6bc0a2")); draw_circle(Vector2(39,-5), 3.5, Color.WHITE); draw_circle(Vector2(40,-5), 1.8, stroke)
	draw_arc(Vector2(42,4), 5, 0.15, 2.0, 12, stroke, 2)
