extends Node2D

var limit = [0, 83, 1008, 227]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interact_area_interact():
	Dialogic.start("meetfy")
