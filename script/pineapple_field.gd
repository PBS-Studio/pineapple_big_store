extends Node2D

const limit:Array[int] = [-256,-240,263,224]

# Called when the node enters the scene tree for the first time.
func _ready():
	if RpgManager.is_first_enter():
		Dialogic.start("wakeup")


func _on_area_2d_body_entered(body):
	RpgManager.change_scene_and_tp("little_road", "ExitPineappleField")
