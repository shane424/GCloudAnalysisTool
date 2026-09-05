extends Node
## Runtime contract suite: invoke with GUT or the project's future test runner.
func test_upgrade_gate() -> void:
	GameState.reset_campaign(); assert(not GameState.buy_upgrade("deep_dive")); GameState.restoration_resources=4; assert(GameState.buy_upgrade("deep_dive")); assert(not GameState.buy_upgrade("deep_dive"))
func test_reward_is_once() -> void:
	GameState.reset_campaign(); assert(GameState.complete_activity("a","sanctuary",2,.2)); assert(not GameState.complete_activity("a","sanctuary",2,.2)); assert(GameState.restoration_resources==2)
func test_progression_gate() -> void:
	GameState.reset_campaign(); assert(not GameState.is_island_unlocked("lumen_reef")); GameState.island_health.driftwood_cay=.65; assert(GameState.is_island_unlocked("lumen_reef"))
func test_serialization_round_trip() -> void:
	GameState.reset_campaign(); GameState.restoration_resources=7; var saved:=GameState.to_dict(); GameState.reset_campaign(); GameState.load_dict(saved); assert(GameState.restoration_resources==7)
func test_corrupt_payload_rejected() -> void:
	assert((SaveManager._migrate({"version":999})).is_empty())
func test_input_actions_exist() -> void:
	for action in ["move_left","move_right","move_up","move_down","interact","dive","sprint","pause"]: assert(InputMap.has_action(action))
