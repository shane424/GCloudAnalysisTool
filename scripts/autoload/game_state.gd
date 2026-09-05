extends Node
## Deterministic campaign state. All rewards are one-time entries keyed by activity id.
signal state_changed
signal island_restored(island_id: String)
signal resource_changed(total: int)

const ISLAND_ORDER := ["sanctuary", "driftwood_cay", "lumen_reef", "mangrove_maze", "tempest_eye"]
const UPGRADE_COSTS := {"deep_dive": 4, "current_glide": 5, "reef_song": 6, "shell_marking": 2}
var restoration_resources := 0
var island_health := {"sanctuary": 0.25, "driftwood_cay": 0.0, "lumen_reef": 0.0, "mangrove_maze": 0.0, "tempest_eye": 0.0}
var completed_activities: Array[String] = []
var upgrades: Array[String] = []
var collectibles: Array[String] = []
var current_island := "sanctuary"
var objective := "objective_first_rescue"
var post_game := false
var play_seconds := 0.0

func _process(delta: float) -> void:
	play_seconds += delta

func reset_campaign() -> void:
	restoration_resources = 0
	island_health = {"sanctuary": 0.25, "driftwood_cay": 0.0, "lumen_reef": 0.0, "mangrove_maze": 0.0, "tempest_eye": 0.0}
	completed_activities.clear(); upgrades.clear(); collectibles.clear()
	current_island = "sanctuary"; objective = "objective_first_rescue"; post_game = false; play_seconds = 0.0
	state_changed.emit()

func complete_activity(id: String, island: String, reward: int, health_gain: float) -> bool:
	if id in completed_activities: return false
	completed_activities.append(id)
	restoration_resources += reward
	island_health[island] = clampf(float(island_health.get(island, 0.0)) + health_gain, 0.0, 1.0)
	resource_changed.emit(restoration_resources)
	if island_health[island] >= 0.99: island_restored.emit(island)
	state_changed.emit()
	return true

func buy_upgrade(id: String) -> bool:
	var cost := int(UPGRADE_COSTS.get(id, 999))
	if id in upgrades or restoration_resources < cost: return false
	restoration_resources -= cost; upgrades.append(id)
	resource_changed.emit(restoration_resources); state_changed.emit()
	return true

func is_island_unlocked(id: String) -> bool:
	var index := ISLAND_ORDER.find(id)
	if index <= 1: return true
	return float(island_health.get(ISLAND_ORDER[index - 1], 0.0)) >= 0.65

func to_dict() -> Dictionary:
	return {"restoration_resources":restoration_resources,"island_health":island_health,"completed_activities":completed_activities,"upgrades":upgrades,"collectibles":collectibles,"current_island":current_island,"objective":objective,"post_game":post_game,"play_seconds":play_seconds}

func load_dict(data: Dictionary) -> void:
	restoration_resources = maxi(0, int(data.get("restoration_resources", 0)))
	for key in island_health: island_health[key] = clampf(float(data.get("island_health", {}).get(key, island_health[key])), 0.0, 1.0)
	completed_activities.assign(data.get("completed_activities", [])); upgrades.assign(data.get("upgrades", [])); collectibles.assign(data.get("collectibles", []))
	current_island = str(data.get("current_island", "sanctuary")); objective = str(data.get("objective", "objective_first_rescue"))
	post_game = bool(data.get("post_game", false)); play_seconds = maxf(0.0, float(data.get("play_seconds", 0.0)))
	state_changed.emit()
