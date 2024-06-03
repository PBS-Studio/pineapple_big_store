extends Node2D

@onready var background = $ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready():
	Bgm.stream_paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background.scroll_offset -= Vector2(1, 1) * 40 * delta


func _on_button_click():
	RpgManager.change_scene("pineapple_field")
	Bgm.stream_paused = false
