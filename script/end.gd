extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Bgm.stream_paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(_event):
	RpgManager.change_scene_no_effect("main_menu")
