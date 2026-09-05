extends CanvasLayer
var resource_label: Label
var objective_label: Label
var health_bar: ProgressBar
var toast: Label

func _ready() -> void:
	var panel := PanelContainer.new(); panel.position = Vector2(28,24); panel.custom_minimum_size = Vector2(350,118); add_child(panel)
	var box := VBoxContainer.new(); box.add_theme_constant_override("separation", 7); panel.add_child(box)
	var title := Label.new(); title.text = tr("HUD_SANCTUARY"); title.add_theme_font_size_override("font_size", 22); box.add_child(title)
	resource_label = Label.new(); box.add_child(resource_label)
	health_bar = ProgressBar.new(); health_bar.show_percentage = false; health_bar.custom_minimum_size.y = 14; box.add_child(health_bar)
	objective_label = Label.new(); objective_label.position = Vector2(28,160); objective_label.custom_minimum_size = Vector2(440,50); objective_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART; add_child(objective_label)
	toast = Label.new(); toast.set_anchors_preset(Control.PRESET_CENTER_TOP); toast.position.y = 28; toast.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; toast.modulate.a = 0.0; add_child(toast)
	GameState.state_changed.connect(refresh); GameState.island_restored.connect(_on_restored); SaveManager.save_started.connect(_on_save)
	refresh()

func refresh() -> void:
	resource_label.text = tr("HUD_RESOURCES") % GameState.restoration_resources
	health_bar.value = float(GameState.island_health.get(GameState.current_island, 0.0)) * 100.0
	objective_label.text = tr("HUD_OBJECTIVE") + "  " + tr(GameState.objective.to_upper())

func _on_restored(_island: String) -> void: show_toast(tr("HUD_RESTORED"))
func _on_save(_slot: int) -> void: show_toast(tr("HUD_AUTOSAVING"))
func show_toast(message: String) -> void:
	toast.text = message; toast.modulate.a = 1.0
	var tween := create_tween(); tween.tween_interval(1.2); tween.tween_property(toast,"modulate:a",0.0,0.4)
