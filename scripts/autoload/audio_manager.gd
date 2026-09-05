extends Node
var music_player: AudioStreamPlayer
var ambience_player: AudioStreamPlayer

func _ready() -> void:
	music_player = AudioStreamPlayer.new(); music_player.bus = "Music"; add_child(music_player)
	ambience_player = AudioStreamPlayer.new(); ambience_player.bus = "Ambience"; add_child(ambience_player)

func play_music(stream: AudioStream, fade_seconds := 1.2) -> void:
	var tween := create_tween(); tween.tween_property(music_player, "volume_db", -40.0, fade_seconds * 0.5)
	await tween.finished
	music_player.stream = stream; music_player.play()
	create_tween().tween_property(music_player, "volume_db", 0.0, fade_seconds * 0.5)

func set_restoration_mix(health: float) -> void:
	# Adaptive stems can bind to this normalized parameter when final licensed tracks are imported.
	ambience_player.pitch_scale = lerpf(0.94, 1.04, clampf(health, 0.0, 1.0))
