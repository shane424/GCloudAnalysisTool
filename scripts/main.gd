extends Node2D
var player: TurtleController
var hud: CanvasLayer

func _ready() -> void:
	_build_world()
	var menu := preload("res://scripts/ui/main_menu.gd").new(); add_child(menu); menu.start_requested.connect(_begin)
	get_tree().paused = true; menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _build_world() -> void:
	var world := Archipelago.new(); world.name = "HandcraftedArchipelago"; add_child(world)
	player = TurtleController.new(); player.name = "Naru"; player.position = Vector2(0,150)
	var shape := CollisionShape2D.new(); var capsule := CapsuleShape2D.new(); capsule.radius=20; capsule.height=62; shape.shape=capsule; player.add_child(shape); add_child(player)
	var camera := IsometricCamera.new(); camera.name="IsometricCamera"; player.add_child(camera)
	for i in range(world.activity_points.size()):
		var trigger := ActivityTrigger.new(); trigger.activity_id=["hatchling_rescue","reef_garden","shell_mechanism","debris_clearing"][i]; trigger.reward=[2,3,3,2][i]; trigger.health_gain=0.2; trigger.position=world.activity_points[i]
		var cs := CollisionShape2D.new(); var circle:=CircleShape2D.new(); circle.radius=65; cs.shape=circle; trigger.add_child(cs); add_child(trigger)

func _begin() -> void:
	get_tree().paused=false
	hud = preload("res://scripts/ui/hud.gd").new(); add_child(hud)
