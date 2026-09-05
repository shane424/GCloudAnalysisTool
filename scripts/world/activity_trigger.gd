class_name ActivityTrigger
extends Area2D
@export var activity_id := "rescue_01"
@export var island_id := "sanctuary"
@export var reward := 2
@export var health_gain := 0.2
@export_multiline var prompt := "Help free the tangled hatchling"
var available := false

func _ready() -> void:
	body_entered.connect(func(body): if body.is_in_group("player"): available = true)
	body_exited.connect(func(body): if body.is_in_group("player"): available = false)

func _process(_delta: float) -> void:
	if available and Input.is_action_just_pressed("interact"):
		if GameState.complete_activity(activity_id, island_id, reward, health_gain):
			GameState.objective = "objective_restore_sanctuary"
			SaveManager.save_slot(0)
