extends Node2D

const limit = [ - 62, 0, 1522, 2208]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_little_road_body_entered(_body):
	RpgManager.change_scene_and_tp("little_road", "ExitCollegeRoad")


func _on_big_road_body_entered(_body):
	RpgManager.change_scene_and_tp("big_road", "ExitCollegeRoad")
