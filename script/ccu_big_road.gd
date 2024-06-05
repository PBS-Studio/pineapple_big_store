extends Node2D

var limit = [ - 48, 0, 1584, 3360]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_corridor_body_entered(_body):
	RpgManager.change_scene_and_tp("corridor", "ExitBigRoad")


func _on_pineapplerain_body_entered(body):
	pass # Replace with function body.


func _on_college_road_body_entered(body):
	RpgManager.change_scene_and_tp("college_road", "ExitBigRoad")
