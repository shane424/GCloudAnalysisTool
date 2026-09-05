class_name Archipelago
extends Node2D
var quality := 1
var time := 0.0
var activity_points := [Vector2(-360,-40),Vector2(250,-160),Vector2(470,160),Vector2(-80,280)]

func _ready() -> void:
	quality = int(Accessibility.get_setting("graphics_preset", 1)); queue_redraw()

func _process(delta: float) -> void:
	time += delta
	if quality > 0: queue_redraw()

func _draw() -> void:
	# Layered hand-shaped coast silhouettes and animated water lines; no cube terrain.
	draw_rect(Rect2(-1600,-900,3200,1800), Color("#0c6680"))
	for i in range(9 if quality > 0 else 4):
		var y := -500.0 + i * 135.0 + sin(time * 0.55 + i) * 8.0
		draw_arc(Vector2(0,y), 1100.0-i*42.0, 0.12, 3.02, 42, Color(0.35,0.86,0.88,0.10), 3.0)
	var shore := PackedVector2Array([Vector2(-720,-90),Vector2(-570,-310),Vector2(-270,-405),Vector2(80,-360),Vector2(365,-245),Vector2(610,-25),Vector2(570,230),Vector2(320,405),Vector2(-10,450),Vector2(-340,370),Vector2(-620,170)])
	draw_colored_polygon(shore, Color("#83d1b3"))
	var sand := PackedVector2Array([Vector2(-650,-65),Vector2(-520,-260),Vector2(-250,-350),Vector2(60,-315),Vector2(320,-210),Vector2(535,0),Vector2(500,190),Vector2(280,340),Vector2(-15,380),Vector2(-315,320),Vector2(-550,145)])
	draw_colored_polygon(sand, Color("#e7c985"))
	var grass := PackedVector2Array([Vector2(-480,-45),Vector2(-380,-205),Vector2(-160,-270),Vector2(95,-250),Vector2(290,-140),Vector2(390,40),Vector2(330,190),Vector2(160,270),Vector2(-90,285),Vector2(-310,220)])
	draw_colored_polygon(grass, Color("#5ca56c"))
	# Reef gardens, sanctuary arches, vegetation, rocks and driftwood silhouettes.
	for p in [Vector2(-500,-215),Vector2(410,-85),Vector2(355,245),Vector2(-280,280)]:
		draw_circle(p, 31, Color("#315f60")); draw_circle(p+Vector2(7,-5), 21, Color("#ea795f")); draw_circle(p+Vector2(-12,8), 12, Color("#f3b55c"))
	for p in [Vector2(-260,-190),Vector2(180,-210),Vector2(285,150)]:
		draw_line(p, p+Vector2(sin(time+p.x)*4,-55), Color("#315f45"), 9); draw_circle(p+Vector2(0,-65), 32, Color("#367d52"))
	draw_arc(Vector2(0,-80), 105, PI, TAU, 28, Color("#ead9aa"), 18); draw_line(Vector2(-105,-80),Vector2(-105,45),Color("#d7bf88"),18); draw_line(Vector2(105,-80),Vector2(105,45),Color("#d7bf88"),18)
	for p in activity_points:
		var pulse := 12.0 + sin(time*3.0+p.x)*2.0
		draw_circle(p, pulse, Color("#ffe58a")); draw_arc(p, pulse+7, 0, TAU, 24, Color("#163f48"), 3)
