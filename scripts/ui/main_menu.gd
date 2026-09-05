extends Control
signal start_requested

func _ready() -> void:
	set_anchors_and_offsets_preset(PRESET_FULL_RECT)
	var shade := ColorRect.new(); shade.color = Color(0.01,0.09,0.12,0.72); shade.set_anchors_and_offsets_preset(PRESET_FULL_RECT); add_child(shade)
	var box := VBoxContainer.new(); box.position = Vector2(90,155); box.custom_minimum_size = Vector2(430,420); box.add_theme_constant_override("separation",14); add_child(box)
	var title := Label.new(); title.text = "TURTLEHAVEN"; title.add_theme_font_size_override("font_size",54); box.add_child(title)
	var subtitle := Label.new(); subtitle.text = tr("MENU_TAGLINE"); subtitle.add_theme_font_size_override("font_size",20); box.add_child(subtitle)
	for spec in [["MENU_CONTINUE",_continue],["MENU_NEW",_new_game],["MENU_SETTINGS",_settings],["MENU_CREDITS",_credits],["MENU_QUIT",_quit]]:
		var button := Button.new(); button.text = tr(spec[0]); button.custom_minimum_size = Vector2(330,46); button.pressed.connect(spec[1]); box.add_child(button)
	box.get_child(2).grab_focus()

func _continue() -> void:
	SaveManager.load_slot(0); start_requested.emit(); queue_free()
func _new_game() -> void:
	GameState.reset_campaign(); start_requested.emit(); queue_free()
func _settings() -> void:
	Accessibility.set_setting("reduced_motion", not Accessibility.get_setting("reduced_motion"));
func _credits() -> void:
	var popup := AcceptDialog.new(); popup.title="Credits"; popup.dialog_text=tr("CREDITS_BODY"); add_child(popup); popup.popup_centered(Vector2i(620,420))
func _quit() -> void: get_tree().quit()
