extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if RpgManager.is_first_enter():
		Dialogic.start("wakeup")
