extends Node2D

const limit = [340, - 83, 2000, 680]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pineapple_field_body_entered(_body):
	RpgManager.change_scene_and_tp("pineapple_field", "ExitLittleRoad")


func _on_college_road_body_entered(_body):
	RpgManager.change_scene_and_tp("college_road", "ExitLittleRoad")
	
