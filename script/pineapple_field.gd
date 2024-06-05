extends Node2D

const limit:Array[int] = [-256,-240,263,224]

@onready var mihon = preload("res://scenes/mihon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if RpgManager.is_first_enter():
		Dialogic.start("wakeup")
		add_child(mihon.instantiate())
		


func _on_area_2d_body_entered(body):
	RpgManager.change_scene_and_tp("little_road", "ExitPineappleField")
